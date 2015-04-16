Admin.UploadMixin = Ember.Mixin.create
  progress: null
  isUploading: Ember.computed.bool('progress')

  actions:
    setProgress: (p) ->
      console.log "Upload progress #{p}"
      # 100% ~ 90% because the last step is post to our server
      @set 'progress', Math.round(p * 0.9)
      false

    uploadFinished: ->
      @set 'progress', null
      # send it to route to create a new MediaItem object on the server
      true
