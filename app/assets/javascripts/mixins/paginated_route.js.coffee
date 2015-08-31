Barbecue.PaginatedRoute = Ember.Mixin.create
  # _renderPagination: ->
  #   @render('pagination',outlet: 'footer',into: 'application')

  queryParams:
    page: { refreshModel: true }

  setupController: (controller,model) ->
    @_setupPagination(controller,model)
    @_super(controller,model)

  _setupPagination: (controller,model) ->
    if data = @_paginationData()
      controller.set('pagination', data)

  _paginationData: (model = @currentModel) ->
    modelType = model.get? && model.get('type')
    if hash = @store.typeMapFor(modelType).metadata.pagination
      Ember.Object.create(hash)
