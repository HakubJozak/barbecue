require 'rails/generators'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
require 'rails/generators/rails/resource_route/resource_route_generator'

require_relative '../generator_helpers'


class Barbecue::ControllerGenerator < Rails::Generators::ScaffoldControllerGenerator
  include Barbecue::GeneratorHelpers

  source_root File.expand_path('../templates', __FILE__)

  class_option :parent, type: :string, default: Barbecue.parent_controller, desc: 'Parent controller class'

  remove_hook_for :test_framework
  remove_hook_for :serializer


  def create_controller_files
    template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
    template "serializer.rb", File.join('app/serializers', controller_class_path, "#{file_name}_serializer.rb")
    template "test.rb", File.join('test/controllers', controller_class_path, "#{controller_file_name}_controller_test.rb")
    add_resource_route
  end

  private

  def has_images?
    attributes.select(&:image?).present?
  end

  def permitted_attributes
    [ attributes.select(&:scalar?).map(&:to_raw).flatten.map { |attr| ":#{attr}"},
      attributes.select(&:image?).map { |a| "#{a.name}: image_attributes"}
    ].flatten.join(",")
  end

  def nested_attributes_fix
    attributes.select(&:image?).map do |a|
      "#{singular_name}[:#{a.name}_attributes] ||= #{singular_name}.delete(:#{a.name})"
    end.join("\n")
  end

  def parent_controller_class_name
    options[:parent]
  end

  def model_class_name
    file_name.camelize
  end

  def serializer_class_name
    "#{class_name}Serializer"
  end



  # Copy pasta from
  # 'rails/generators/rails/resource_route/resource_route_generator'
  #
  # :\
  #
  #
  # Properly nests namespaces passed into a generator
  #
  #   $ rails generate resource admin/users/products
  #
  # should give you
  #
  #   namespace :admin do
  #     namespace :users do
  #       resources :products
  #     end
  #   end
  def add_resource_route
    return if options[:actions].present?

    # iterates over all namespaces and opens up blocks
    regular_class_path.each_with_index do |namespace, index|
      write("namespace :#{namespace} do", index + 1)
    end

    # inserts the primary resource
    write("resources :#{file_name.pluralize}", route_length + 1)

    # ends blocks
    regular_class_path.each_index do |index|
      write("end", route_length - index)
    end

    # route prepends two spaces onto the front of the string that is passed, this corrects that
    route route_string[2..-1]
  end

  def route_string
    @route_string ||= ""
  end

  def write(str, indent)
    route_string << "#{"  " * indent}#{str}\n"
  end

  def route_length
    regular_class_path.length
  end




end
