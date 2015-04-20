Barbecue.UploadMixin = Ember.Mixin.create
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
      @set 'progress',90
      photo = @get('model')
      photo.set('sourceUrl',url)
      photo.save().then ( (saved_record) =>
        @set 'progress',null
        @flashInfo 'File saved.'
      ), ( (e) =>
        @set 'progress',null
        @flashError 'File upload failed.'
      )
      false
