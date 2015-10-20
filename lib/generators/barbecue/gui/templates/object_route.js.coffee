<%= application_name.camelize %>.<%= class_name.camelize %>Route = <%= application_name.camelize %>.BaseRoute.extend
  model: (params) ->
    if params.id == 'new'
      @store.createRecord('<%= name %>')
    else
      @store.find('<%= name %>',params.id)
