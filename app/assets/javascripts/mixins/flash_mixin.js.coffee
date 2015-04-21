Barbecue.FlashMixin = Ember.Mixin.create
  flashInfo: (msg) ->
    console.info 'Flash:', msg
    flash = Ember.Object.create(type: 'success', message: msg)
    @controllerFor('application').set('flash', flash)

  flashError: (msg) ->
    console.error 'Flash:',msg
    flash = Ember.Object.create(type: 'error', message: msg)
    @controllerFor('application').set('flash',flash)
