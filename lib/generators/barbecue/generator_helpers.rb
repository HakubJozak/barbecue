module Barbecue::GeneratorHelpers
  private

  # Overriding method from Rails internals!
  def parse_attributes! #:nodoc:
    self.attributes = (attributes || []).map do |attr|
      Barbecue::Generators::GeneratedAttribute.parse(attr)
    end
  end  

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
    '--force' if options['force'] == true
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

  def serializers_path(filename)
    File.join(ember_path, 'serializers', filename)
  end  

  def controllers_path(filename)
    File.join(ember_path, 'controllers', class_path, filename)
  end
end
