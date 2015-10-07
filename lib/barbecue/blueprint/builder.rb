class Barbecue::Blueprint::Builder
  attr_reader :models, :flags

  def initialize
    @models = []
    @uses = []
    @generators = {
      controller: true,
      model: true,
      admin: true,
    }
    @flags = {}
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

  def enabled?(generator)
    @generators[generator]
  end

  def enable(key,flags = nil)
    @generators[key] = true
    @flags[key] = flags if flags
  end

  alias :flags_for :enable

  def disable(key)
    @generators[key] = false
  end

  def model(name,&block)
    m = Barbecue::Blueprint::Model.new(name)
    m.instance_eval(&block) if block_given?
    @models << m
    m
  end

end
