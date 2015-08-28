Barbecue.PaginationControlsComponent = Ember.Component.extend
  layoutName: 'barbecue/pagination'

  just_one_page: Ember.computed.equal('model.total_pages',1)
  first_page: Ember.computed.equal('model.current_page',1)
  empty: Ember.computed.equal('model.total',0)
  perPage: 20 # Volant.settings.perPage

  previous_page: (->
    if @get('model.current_page') > 1
      @get('model.current_page') - 1
    else
      null
  ).property('model.current_page')

  next_page: (->
    if @get('model.current_page') < @get('model.total_pages')
      parseInt(@get('model.current_page')) + 1
    else
      null
  ).property('model.current_page')
