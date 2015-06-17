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

  def string_field(attr,html_type = 'text')
    value = without_locale(attr).camelize(:lower)
    %{= input value=#{value} type='#{html_type}'}
  end

  def textarea(attr)
    value = without_locale(attr).camelize(:lower)
    %{= textarea value=#{value} class='form-control'}
  end

  def input_field(attr)
    case attr.type
    when :string then string_field(attr)
    when :text then textarea(attr)
    when :integer then string_field(attr,'number')
    when :datetime then date_field(attr)
    end
  end

  def ember_type(attr)
    case attr.type
    when :datetime,:date then 'isodate'
    when :integer,:decimal then 'number'
    when :boolean, then 'boolean'
    when :text then 'string'
    else :string
    end
  end

end
