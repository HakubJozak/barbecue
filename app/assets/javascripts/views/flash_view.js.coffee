Barbecue.FlashView = Ember.View.extend
  elementName: 'p'
  classNameBindings: [ ':flash','type' ]
  templateName: 'flash'

  type: Ember.computed.alias('controller.type')
  message: Ember.computed.alias('controller.message')        

  actions:
    close: ->
      @$().hide()

  showFlash: ( ->
    if msg = @get('message')
      console.log 'Showing flash:',msg
      @$().fadeIn()
      Ember.run.later((=> @$().fadeOut() ),5000)
    else
      console.log 'No flash to show.'
  ).observes('message').on('init')


