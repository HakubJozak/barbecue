require 'rails/generators'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
require 'rails/generators/rails/resource_route/resource_route_generator'


class Barbecue::ControllerGenerator < Rails::Generators::ScaffoldControllerGenerator
  source_root File.expand_path('../templates', __FILE__)

  class_option :parent, type: :string, default: Barbecue.parent_controller, desc: 'Parent controller class'

  remove_hook_for :test_framework


  def create_controller_files
    template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
    template "test.rb", File.join('test/controllers', controller_class_path, "#{controller_file_name}_controller_test.rb")
    add_resource_route
  end

  protected

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

  private

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
