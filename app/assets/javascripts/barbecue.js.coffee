#= require_self
#= require ./translated_property
#= require_tree ./adapters
#= require_tree ./transform
#= require_tree ./components
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates

Barbecue = Ember.Namespace.create()

Ember.Application.initializer
  name: 'barbecueInitializer'

  # FYI - you can use:
  # after: 'otherInitializer'
  # before: 'otherInitializer'

  initialize: (container,application) ->
    # FYI: store = container.lookup('store:main')
    # FYI: adapter = container.lookup('adapter:application')
    container.register 'component:link-li', Barbecue.LinkLiComponent
    container.register 'component:upload-button', Barbecue.UploadButtonComponent
    container.register 'view:form-group', Barbecue.FormGroupView
    container.register 'view:date', Barbecue.DateView
    container.register 'transform:isodate', Barbecue.IsodateTransform
    console.debug 'Barbecue 0.2'

Barbecue.removeTemplatePrefix = (regexp) ->
  for key,template of Ember.TEMPLATES
    if key.match(regexp)
      unscoped = key.replace(regexp,'')
      Ember.TEMPLATES[unscoped] = template;
      console.info "Renamed template '#{key}' to '#{unscoped}'"


# Export
window.Barbecue = Barbecue
