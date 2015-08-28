Barbecue.ModelAjaxMixin = Ember.Mixin.create

 _ajax: (url, method, options) ->
    id = @get 'id'
    type    = @get 'constructor'
    adapter = @get('store').adapterFor type
    url     = '%@/%@/%@'.fmt adapter.buildURL(type.typeKey), id, url

    adapter.ajax url, method, options


  post: (url, options) ->
    @_ajax url, 'POST', options


