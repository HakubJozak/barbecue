# Usage (not tested!):
#
#  Admin.MediaPlacement = Barbecue.MediaPlacement.extend
#    page: DS.belongsTo('page',async: true,polymorphic: true)
#
Barbecue.MediaPlacement = DS.Model.extend
  titleEn: DS.attr 'string'
  titleCs: DS.attr 'string'
  position: DS.attr 'number'
  # featured: DS.attr 'boolean'
  # notFeatured: Ember.computed.not('featured')
  # coverColumns: DS.attr 'number'
  mediaItem: DS.belongsTo('mediaItem')



