#= require ember-uploader/dist/ember-uploader.js

#= require_self
#= require ./i18n
#= require ./translated_property
#= require_tree ./adapters
#= require_tree ./transform
#= require_tree ./controllers
#= require_tree ./components
#= require_tree ./views
#= require_tree ./mixins
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
    container.register 'component:bbq-progress-bar', Barbecue.ProgressBar
    container.register 'view:bbq-text-field', Barbecue.TextField
    container.register 'view:form-group', Barbecue.FormGroupView
    container.register 'view:date', Barbecue.DateView
    container.register 'transform:isodate', Barbecue.IsodateTransform
    container.register 'controller:contentLocale', Barbecue.ContentLocaleController
    console.debug 'Barbecue 0.2'

Barbecue.removeTemplatePrefix = (regexp) ->
  for key,template of Ember.TEMPLATES
    if key.match(regexp)
      unscoped = key.replace(regexp,'')
      Ember.TEMPLATES[unscoped] = template;
      console.info "Renamed template '#{key}' to '#{unscoped}'"


# Export
window.Barbecue = Barbecue
