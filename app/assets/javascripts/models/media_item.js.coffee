Barbecue.MediaItem = DS.Model.extend
  type: DS.attr 'string'
  titleEn: DS.attr 'string'
  titleCs: DS.attr 'string'
  copyrightEn: DS.attr 'string'
  copyrightCs: DS.attr 'string'
  sourceUrl: DS.attr 'string'
  thumbnailUrl: DS.attr 'string'

  isVideo: (->
    t = @get('type')
    t == 'video' or t == 'youtube_video'
  ).property('type')
