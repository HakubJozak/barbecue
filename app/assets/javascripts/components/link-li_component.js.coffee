Barbecue.LinkLiComponent = Ember.Component.extend({
  tagName: 'li',
  classNameBindings: ['active'],
  active: (->
    @get('childViews').anyBy('active')
  ).property('childViews.@each.active')
})
