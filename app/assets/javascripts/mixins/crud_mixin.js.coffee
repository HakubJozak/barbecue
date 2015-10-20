Barbecue.CrudMixin = Ember.Mixin.create
  actions:
    save: (record) ->
      record ||= @_guessRecord()

      if errors = record.get('errors')
        errors.clear()

      record.save().then ( (saved_record) =>
        @afterSave(saved_record)
       ), ( (e) =>
         @flashError 'Save failed.'
       )
      false

    rollback: (record) ->
      record ||= @_guessRecord()

      if errors = record.get('errors')
        errors.clear()
         
      record.rollback()
      @afterRollback()
      false

    remove: (record) ->
      record ||= @_guessRecord()
      title = @_guessTitle(record)
      return unless confirm("Do you really want to delete #{title}?")

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

  _guessRecord: ->
    @currentModel || @get('model')

  _guessTitle: (record) ->
    @get('title') || record.get('title')

  afterRemove: (record) ->
    @goToPluralRoute record
    @flashInfo 'Deleted.'

  afterRollback: (record) ->
    @goToPluralRoute record

  afterSave: (record) ->
    @goToPluralRoute record
    @flashInfo('Saved.')

  goToPluralRoute: (record = @currentModel) ->
    next_route = record.constructor.typeKey.decamelize().pluralize()
    @transitionTo next_route if @routeName != next_route
