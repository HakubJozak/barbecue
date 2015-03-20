# Requirements:
#   - property 'contentLocale' defined in the context
#   - setting Barbecue.CONTENT_LOCALES to a list of available locales ['cs','en']
#
#
# Usage:
#
#  Admin.PageController = Admin.ObjectController.extend
#    title: Barbecue.translatedProperty('title')
#    titlePlaceholder: Barbecue.translatedProperty('title',fallback: true)
#
# Will result in a dynamic property setting titleEn and titleCs
# depending on the currently set 'contentLocale'.
#
#
Barbecue.translatedProperty = (attr,options = { fallback: false }) ->

  unless Barbecue.CONTENT_LOCALES      
    throw "Please set Barbecue.CONTENT_LOCALES to something like ['cs','en']"
        
  accessor = (that,value) ->
    localeSuffix = @get('contentLocale').capitalize()

    if arguments.length > 1
      @set "#{attr}#{localeSuffix}",value
    else
      if options.fallback
        current = @get('contentLocale')
        fallback = Barbecue.CONTENT_LOCALES.filter (l) -> (current != l)

        values = fallback.map (l) =>
          prop = @get("#{attr}#{l.capitalize()}")

          if Ember.isBlank(prop)
            null
          else
            prop

        values.unshift @get "#{attr}#{localeSuffix}"

        # what should we return when there is no translation available?
        values.push options.default || '' # attr.capitalize()

        # find first non-nil

        values.find((x) -> x)
      else
        @get "#{attr}#{localeSuffix}"

  # build up a list of dependent, language specific properties
  args = Barbecue.CONTENT_LOCALES.map (locale) ->
    suffix = locale.capitalize()
    "#{attr}#{suffix}"

  # add currentLocale and attribute as a dependency
  args.push 'contentLocale'
  args.push accessor

  Ember.computed.apply this,args
