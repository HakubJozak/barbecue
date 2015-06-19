Barbecue.UploadWidgetComponent = Ember.Component.extend
  layoutName: 'components/barbecue/upload_widget'
  classNames: ['upload-widget']
  type: 'image'  
  attr: null
  model: null

  progress: null
  isUploading: Ember.computed.bool('progress')

  actions:
    setProgress: (p) ->
      console.log "Upload progress #{p}"
      # 100% ~ 90% because the last step is post to our server
      @set 'progress', Math.round(p * 0.9)
      false

    saveSourceUrl: (url,name,mimeType) ->
      console.log "Upload finished: #{url}"
      @set 'progress',null

      # HACK - move the whole logic somewhere else?  
      store = @get('targetObject.store')
      owner = @get('owner')
      attribute = @get('attr')
      type = @get('type')

      image = owner.get(attribute) || store.createRecord(type)
      image.set('sourceUrl',url)
      owner.set(attribute,image)
      owner.save()
      false

    


