require 'rails/generators'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'


class Barbecue::ControllerGenerator < Rails::Generators::ScaffoldControllerGenerator
  source_root File.expand_path('../templates', __FILE__)

  protected

  def serializer_class_name
    "#{class_name}Serializer"
  end

  def model_class_name
    file_name.camelize
  end

end
