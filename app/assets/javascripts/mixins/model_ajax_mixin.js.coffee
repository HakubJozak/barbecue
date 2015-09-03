Barbecue.ModelAjaxMixin = Ember.Mixin.create

  _ajax: (url, method, options) ->
    id = @get 'id'
    type    = @get 'constructor'
    store   = @get 'store'
    adapter = store.adapterFor type
    url     = '%@/%@/%@'.fmt adapter.buildURL(type.typeKey), id, url

    success = (response) =>
      store.pushPayload(type.typeKey,response)
      console.info 'inserted'

    error = (response) =>
      # we have to manually add the errors  
      for attr,message of response.errors.errors
        prop = attr.camelize()
        @get('errors').add(prop,message)

    # we have to change the model state so that
    # later on, errors can be added    
    @adapterWillCommit()
    adapter.ajax(url, method, options).then success,error

  post: (url, data) ->
    @_ajax url, 'POST', { data: data }


