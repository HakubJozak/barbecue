Barbecue.ModelAjaxMixin = Ember.Mixin.create

 _ajax: (url, method, options) ->
    id = @get 'id'
    type    = @get 'constructor'
    store   = @get 'store'
    adapter = store.adapterFor type
    url     = '%@/%@/%@'.fmt adapter.buildURL(type.typeKey), id, url

    adapter.ajax(url, method, options).then (response) =>
      store.pushPayload(type.typeKey,response)
      console.info 'inserted'




  post: (url, options) ->
    @_ajax url, 'POST', options


