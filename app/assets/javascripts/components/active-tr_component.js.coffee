Barbecue.ActiveTrComponent = Ember.Component.extend
  tagName: 'tr',
  classNameBindings: ['active'],
  active: (->
    @get('childViews').anyBy('active')
  ).property('childViews.@each.active')

