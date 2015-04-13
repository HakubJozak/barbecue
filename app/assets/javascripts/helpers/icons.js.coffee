Ember.Handlebars.helper 'fa', (name,clazz='') ->
  new Handlebars.SafeString "<i class='fa fa-#{name} #{clazz}'></i>"
