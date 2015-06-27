<% module_namespacing do -%>
class <%= serializer_class_name %> < ActiveModel::Serializer
  attributes :id
  <% attributes.each do |attr|  -%>
  <%= attr.code_for_serializer %>
  <% end -%>
end
<% end -%>
