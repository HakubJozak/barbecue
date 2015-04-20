Barbecue.ProgressBar = Ember.Component.extend
  layoutName: 'components/barbecue/progress_bar'

  style: (->
    "width: #{@get('value')}%;"
  ).property('value')
