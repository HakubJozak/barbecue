<%= application_name.camelize %>.<%= class_name.camelize %>Serializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    <%- attributes.map(&:ember_embedded_record).compact.each do |code| -%>
    <%= code %>    
    <%- end -%>

  typeForRoot: (key) ->
    <%- attributes.map(&:ember_type_for_root).compact.each do |code| -%>
    <%= code %>    
    <%- end -%>
    @_super(key)
