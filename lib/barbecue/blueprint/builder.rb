class Barbecue::Blueprint::Builder
  attr_reader :models

  def initialize
    @models = []
  end

  def uses(feature)
    case feature
    when :media_placements
    # TODO
    when :media_items
    # TODO
    # @generator.invoke 'barbecue:media_items_migration'
    when :menu_items
    # TODO
    else
      raise "Unknown feature '#{feature}'"
    end
  end

  def model(name,&block)
    m = Barbecue::Blueprint::Model.new(name)
    m.instance_eval(&block) if block_given?
    @models << m
    m
  end

end
