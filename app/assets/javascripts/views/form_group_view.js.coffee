Barbecue.FormGroupView = Ember.View.extend
  translated: true
  classNameBindings:  [ ":form-group", "hasError:has-error" ]
  layoutName: 'form_group_layout'

  errorMessages: (->

    errors = @get("context.errors.#{@_propertyName()}")

    if errors
      errors.map( (i)-> i.message ).join(',')
    else
      ''
  ).property('context.errors.[].message','attr','context.contentLocale')

  hasError: (->
    attr = @get('attr')
    errors = @get("context.errors.#{@_propertyName()}")
    errors && errors.length > 0
  ).property('context.errors.[].message','attr')

  _propertyName: ->
    if @get('translated')    
      localeSuffix = @get('context.contentLocale').capitalize()
      attr = @get('attr')
      property = "#{attr}#{localeSuffix}"
    else
      @get('attr')              
