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
      type = @get('type')

      if attribute = @get('attr')
        image = owner.get(attribute) || store.createRecord(type)
        image.set('sourceUrl',url)
        owner.set(attribute,image)
        owner.save()
      else if attribute = @get('array')
        image = owner.get(attribute).createRecord()
        image.set('sourceUrl',url)
        owner.save()        
      else
        console.error "Set 'array' or 'attr' property"
        throw new "Set 'array' or 'attr' property"
      false

    


