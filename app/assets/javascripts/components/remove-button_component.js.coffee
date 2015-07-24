Barbecue.RemoveButtonComponent = Ember.Component.extend
#  layoutName: 'components/barbecue/remove-button'
  templateName: 'components/barbecue/remove-button'  
  icon: 'times'
  click: ->
    @sendAction('action',@get('param'))
    false
