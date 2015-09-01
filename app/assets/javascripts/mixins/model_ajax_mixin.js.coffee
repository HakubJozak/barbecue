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
      # TODO: handle becameInvalid!
      # see http://emberjs.com/api/data/classes/DS.RootState.html  
      @get('errors').add('rejectReson','sdfdsfdsf')
      
    adapter.ajax(url, method, options).then success,error


  post: (url, data) ->
    @_ajax url, 'PUT', { data: data }


