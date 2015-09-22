Barbecue.UploadWidgetComponent = Ember.Component.extend
  layoutName: 'components/barbecue/upload_widget'
  classNames: ['upload-widget']
  type: 'image'
  attr: null
  model: null
  saveAction: null

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
      image = null

      if attribute = @get('attr')
        image = owner.get(attribute) || store.createRecord(type)
        owner.set(attribute,image)
      else if attribute = @get('array')
        image = owner.get(attribute).createRecord()
      else
        console.error "Set 'array' or 'attr' property"
        throw new "Set 'array' or 'attr' property"

      image.set('sourceUrl',url)

      if Ember.isEmpty(@get('saveAction'))
        owner.save()
      else
        @sendAction('saveAction',image)

      false
