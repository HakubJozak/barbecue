<%= application_name.camelize %>.<%= class_name.camelize %>Serializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  images: [ <%= image_attributes.map {|a| "'#{a.ember_name}'" }.join(',') %> ]
  attrs:
    <%- attributes.map(&:ember_embedded_record).compact.each do |code| -%>
    <%= code %>    
    <%- end -%>

  typeForRoot: (key) ->
    if @get('images').indexOf(key) > 0
      'image'
    else
      @_super(key)
