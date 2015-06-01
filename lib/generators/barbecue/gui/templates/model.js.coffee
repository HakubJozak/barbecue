<%= application_name.camelize %>.<%= class_name.camelize %> = DS.Model.extend
  # photo: DS.belongsTo 'mediaItem'

  <%- attributes.each do |attr| -%>
  <%= attr.name.camelize(:lower) %>: DS.attr 'string'
  <%- end -%>
