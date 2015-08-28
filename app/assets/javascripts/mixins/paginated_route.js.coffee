Barbecue.PaginatedRoute = Ember.Mixin.create
  _renderPagination: ->
    @render('pagination',outlet: 'footer',into: 'application')          

  _setupPagination: (controller,model) ->
    if data = @_paginationData()
      controller.set('controllers.pagination.model', data)

  _paginationData: (model = @currentModel) ->
    modelType = model.get? && model.get('type')
    if hash = @store.typeMapFor(modelType).metadata.pagination
      Ember.Object.create(hash)
