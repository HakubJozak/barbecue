class Barbecue::BlueprintGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_models
    generate 'model title_cs:string title_en:string'
  end
end
