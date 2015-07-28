Barbecue.AjaxMixin = Ember.Mixin.create
  postToServer: (url,data = {},options = {}) ->
    new Promise (resolve, reject) =>
      csrf_token = $('meta[name="csrf-token"]').attr('content')
      csrf_param = $('meta[name="csrf-param"]').attr('content')
      data.authenticity_token = csrf_token

      try
        $.ajax
          url: url
          type: options.type || 'POST'
          data: data
          success: (response) =>
            console.info 'Payload', response
            @store.pushPayload(options.serializer || 'menu_item',response)
            resolve(response)

          error: (response) =>
            reject(response)
      catch e
        reject(e)
