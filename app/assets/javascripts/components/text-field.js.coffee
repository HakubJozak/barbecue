Barbecue.TextField = Ember.View.extend
  attr: null
  layoutName: 'components/barbecue/text_field'

  label: (->
    @get("context.#{@get('attr')}").capitalize()
  ).property('attr')

