Barbecue.CrudMixin = Ember.Mixin.create
  actions:
    save: (record) ->
      record ||= @currentModel
      record.get('errors').clear()
      record.save().then ( (saved_record) =>
        @afterSave(saved_record)
       ), ( (e) =>
         @flashError 'Save failed.'
       )
      false

    rollback: (record) ->
      record ||= @currentModel
      record.get('errors').clear()
      record.rollback()
      @afterRollback()
      false

    remove: (record) ->
      record ||= @currentModel
      if record.get('isNew')
        record.deleteRecord()
      else
        record.destroyRecord().then (=>
          @afterRemove()
          ), ( (e) =>
           console.error e
           @flashError "Failed."
          )
      false

  afterRemove: (record) ->
    @transitionTo 'application'
    @flashInfo 'Deleted.'

  afterRollback: (record) ->
    @transitionTo 'application'

  afterSave: (record) ->
    @transitionTo 'application'
    @flashInfo('Saved.')

  goToPluralRoute: (record = @currentModel) ->
    next_route = record.constructor.typeKey.decamelize().pluralize()
    @transitionTo next_route if @routeName != next_route
