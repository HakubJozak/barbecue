class Barbecue::Blueprint::Builder
  attr_reader :models

  def initialize
    @models = []
    @uses = []
  end

  # def uses(feature)
  #   if feature == :images
  #     @uses << feature
  #   else
  #     raise "Unknown feature '#{feature}'"
  #   end
  # end

  def uses?(feature)
    @uses.include?(feature)
    @models.find { |m| m.uses?(feature) }
  end

  def model(name,&block)
    m = Barbecue::Blueprint::Model.new(name)
    m.instance_eval(&block) if block_given?
    @models << m
    m
  end

end
