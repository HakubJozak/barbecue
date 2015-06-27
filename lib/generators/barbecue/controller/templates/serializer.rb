<% module_namespacing do -%>
class <%= serializer_class_name %> < ActiveModel::Serializer
  attribute :id
  <% attributes.each do |attr|  -%>
  <%= attr.code_for_serializer %>
  <% end -%>
end
<% end -%>
