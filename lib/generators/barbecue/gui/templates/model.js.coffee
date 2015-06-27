<%= application_name.camelize %>.<%= class_name.camelize %> = DS.Model.extend
  <%- attributes.flatten.each do |attr| -%>
  <%- attr.to_raw.each do |name| -%>
  <%= name.to_s.camelize(:lower) %>: <%= attr.ember_data_type %>
  <%- end -%>
  <%- end -%>
