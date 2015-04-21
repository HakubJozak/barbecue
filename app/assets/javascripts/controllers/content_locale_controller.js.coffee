Barbecue.ContentLocaleController = Ember.ObjectController.extend
  model: 'cs'

  current: Ember.computed.alias('model')

  localeOptions: (->
    Barbecue.CONTENT_LOCALES.map (locale) ->
      { code: locale, label: I18n.t("locales.#{locale}.name") }
  ).property()
