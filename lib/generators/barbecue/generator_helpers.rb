module Barbecue::GeneratorHelpers
  private

  def templates_path(filename)
    File.join(ember_path, 'templates', class_path, filename)
  end

  def routes_path(filename)
    File.join(ember_path, 'routes', class_path, filename)
  end

  def models_path(filename)
    File.join(ember_path, 'models', class_path, filename)
  end

  def controllers_path(filename)
    File.join(ember_path, 'controllers', class_path, filename)
  end
end
