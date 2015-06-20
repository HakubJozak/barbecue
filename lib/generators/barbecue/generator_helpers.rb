module Barbecue::GeneratorHelpers
  private

  def say!(msg)
    say "#{@name.to_s.capitalize} - #{msg}", output_color
  end

  def output_color
    if behavior == :invoke
      :green
    else # == :revoke
      :red
    end
  end

  def force_flag
    '--force' if options['force']
  end

  def migration_flag
    '--no-migration' if options['migration'] == false
  end


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
