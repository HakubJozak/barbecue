<%= application_name.camelize %>.<%= class_name.camelize %>Controller = <%= application_name.camelize %>.ObjectController.extend
  needs: ['contentLocale']
  contentLocale: Ember.computed.alias('controllers.contentLocale.current')

  <%- translated_attribute_names.each do |name| -%>
  <%= name.camelize(:lower) %>: Barbecue.translatedProperty('<%= name.camelize(:lower) %>')
  <%- end -%>
