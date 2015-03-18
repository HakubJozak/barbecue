# Usage:
#
#  Admin.PageController = Admin.ObjectController.extend
#    title: Barbecue.translatedProperty('title')
#    titlePlaceholder: Barbecue.translatedProperty('title',fallback: true)
#
Barbecue.translatedProperty = (attr,options = { fallback: false }) ->

  accessor = (that,value) ->
    localeSuffix = @get('contentLocale').capitalize()

    if arguments.length > 1
      @set "#{attr}#{localeSuffix}",value
    else
      if options.fallback
        current = @get('contentLocale')
        fallback = Admin.locales.filter (l) -> (current != l)

        values = fallback.map (l) =>
          prop = @get("#{attr}#{l.capitalize()}")

          if Ember.isBlank(prop)
            null
          else
            prop

        values.push options.default || '' # attr.capitalize()

        # find first non-nil    
        values.find((x) -> x)
      else  
        @get "#{attr}#{localeSuffix}"

  # build up a list of dependent, language specific properties
  args = Admin.locales.map (locale) ->
    suffix = locale.capitalize()
    "#{attr}#{suffix}"

  # add currentLocale and attribute as a dependency
  args.push 'contentLocale'
  args.push accessor

  Ember.computed.apply this,args
