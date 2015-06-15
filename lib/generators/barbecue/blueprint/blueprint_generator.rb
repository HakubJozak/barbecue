require 'barbecue'

class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :filename, type: :string

  def create_models
    Barbecue::Dsl.blueprint(self,File.read(filename),filename: filename)
  end

end
