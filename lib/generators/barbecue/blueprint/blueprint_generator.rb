class Barbecue::BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :file, type: :string

  def create_models
    Barbecue::Dsl.blueprint
    generate 'model', 'project','title_cs:string','title_en:string'
  end
end
