Barbecue.UploadButtonComponent = EmberUploader.FileField.extend
#  layoutName: 'components/barbecue/upload_button'
  classNames: ['upload-button']
  multiple: true
  url: '/admin/upload'

  filesDidChange: (->
    uploadUrl = @get('url')
    files = @get('files')
    uploader = EmberUploader.S3Uploader.create(url: uploadUrl)

    uploader.on 'didUpload', (response) =>
      # S3 will return XML like this:
      #
      # <PostResponse>
      #    <Location>http://media.bu2r.cz.s3.amazonaws.com/development%2Fvideos%2F1.mov</Location>
      #    <Bucket>media.bu2r.cz</Bucket>
      #    <Key>development/videos/1.mov</Key>
      #    <ETag>"fe38f61d1e97c16e9eee52224e438f6c"</ETag>
      # </PostResponse>
      #
      name = @_filename(response)
      uploadedUrl = $(response).find('Location')[0].textContent
      url = decodeURIComponent(uploadedUrl)
      @sendAction('uploaded',url,name,@get('mimeType'))

    uploader.on 'progress', (e) =>
      @sendAction('progressed',e.percent)

    unless Ember.isEmpty(files)
      for file in files
        # HACK
        @set 'mimeType',file.type
        uploader.upload file
  ).observes('files')

  _filename: (response) ->
    key = $(response).find('Key')[0].textContent
    bits = key.split('/')
    bits[bits.length - 1]
