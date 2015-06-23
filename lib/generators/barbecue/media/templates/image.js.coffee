Admin.Image = DS.Model.extend
#  owner: DS.belongsTo('project',polymorphic: true)

  sourceUrl: DS.attr 'string'
  titleCs: DS.attr 'string'
  titleEn: DS.attr 'string'
  copyrightCs: DS.attr 'string'
  copyrightEn: DS.attr 'string'
  thumbnailUrl: DS.attr 'string'
