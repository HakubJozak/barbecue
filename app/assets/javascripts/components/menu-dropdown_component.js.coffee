Barbecue.MenuDropdownComponent = Ember.Component.extend({
  tagName: 'li'
  classNames: [ 'dropdown' ]
})

Ember.Handlebars.helper('menu-dropdown', Barbecue.MenuDropdownComponent)
