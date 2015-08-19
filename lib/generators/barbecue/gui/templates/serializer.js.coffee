<%= application_name.camelize %>.<%= class_name.camelize %>Serializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  <%- embedded = attributes.map(&:ember_embedded_record).compact -%>
  <%- if embedded.present? %>
  attrs:
    <%- embedded.each do |code| -%>
    <%= code %>
    <%- end -%>
  <%- end -%>            

  typeForRoot: (key) ->
    <%- attributes.map(&:ember_type_for_root).compact.each do |code| -%>
    <%= code %>
    <%- end -%>
    @_super(key)
