<%= application_name.camelize %>.<%= class_name.camelize %>Controller = <%= application_name.camelize %>.ObjectController.extend
  needs: ['contentLocale']
  contentLocale: Ember.computed.alias('controllers.contentLocale.current')

  <%- attributes.select(&:translated?).each do |attr| -%>
  <%= attr.name.camelize(:lower) %>: Barbecue.translatedProperty('<%= attr.name.camelize(:lower) %>')
  <%- end -%>
