Barbecue.UploadWidgetComponent = Ember.Component.extend
  layoutName: 'components/barbecue/upload_widget'
  classNames: ['upload-widget']
  attr: 'image'

  progress: null
  isUploading: Ember.computed.bool('progress')

  actions:
    setProgress: (p) ->
      console.log "Upload progress #{p}"
      # 100% ~ 90% because the last step is post to our server
      @set 'progress', Math.round(p * 0.9)
      false

    saveSourceUrl: (url) ->
      console.log "Upload finished: #{url}"
      @set 'progress',null
      # send it to route
      true
