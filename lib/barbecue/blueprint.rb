require 'rails/generators/rails/app/app_generator'


module Barbecue::Blueprint

  def self.create(definition = nil, opts = {}, &block)
    builder = Builder.new

    if definition
      builder.instance_eval(definition,opts[:filename])
    elsif block_given?
      builder.instance_eval(&block)
    else
      raise 'You have to supply either definition string or a block with blueprint commands.'
    end

    builder
  end

end
