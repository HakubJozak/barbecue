Barbecue.MediaItemController = Ember.ObjectController.extend
  needs: ['contentLocale']
  contentLocale: Ember.computed.alias('controllers.contentLocale.current')

  title: Barbecue.translatedProperty('title')
  copyright: Barbecue.translatedProperty('copyright')  
