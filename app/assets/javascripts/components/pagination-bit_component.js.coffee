# Required property: currentPage
#
Barbecue.PaginationBitComponent = Ember.Component.extend
  layoutName: 'components/barbecue/pagination-bit'
  tagName: 'li'
  classNameBindings: [ 'active', 'disabled']

  disabled: (->
    !(@get('active') || @get('link'))
  ).property('active','link')

  active: (->
    @get('model').toString() == @get('currentPage').toString()
  ).property('model','currentPage')

  link: (->
    @get('model') != '...'
  ).property('model')

  click: ->
    if @get('link')
      newPage = @get('model')
      @set('currentPage',newPage)
