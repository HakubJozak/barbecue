module Barbecue::TemplateHelpers

  def without_locale(attr)
    if translated_attribute?(attr)
      attr.name[0..-4]
    else
      attr.name
    end
  end

  def translated_attribute?(attr)
    locales = I18n.available_locales.join('|')
    attr.name =~ /.*_(#{locales})$/
  end

  def date_field(attr)
    binding = without_locale(attr).camelize(:lower)
    %{= view 'date' dateBinding='#{binding}'}
  end

  def boolean_field(attr)
    value = without_locale(attr).camelize(:lower)
    %{= input checked=#{value} type='checkbox'}
  end

  def string_field(attr,html_type = 'text',attributes = {})
    details = attributes.each_pair.map { |k,v| "#{k}=#{v}"}.join(' ')
    value = without_locale(attr).camelize(:lower)
    %{= input value=#{value} type='#{html_type}' #{details}}
  end

  def textarea(attr)
    value = without_locale(attr).camelize(:lower)
    %{= textarea value=#{value} class='form-control'}
  end

  def input_field(attr)
    case attr.type
    when :string then string_field(attr)
    when :text then textarea(attr)
    when :boolean then boolean_field(attr)
    when :integer then string_field(attr,'number')
    when :decimal then string_field(attr,'number',step: '"0.01"')
    when :email then string_field(attr,'email')      
    when :datetime then date_field(attr)
    else string_field(attr)
    end
  end

  # rename ember_model_type
  def ember_type(attr)
    case attr.type
    when :datetime,:date then 'isodate'
    when :integer,:decimal then 'number'
    when :boolean then 'boolean'
    when :text then 'string'
    else :string
    end
  end

end
