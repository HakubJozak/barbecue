I18n =
  # User interface local
  # TODO: make it dynamic
  locale: 'en'

  translations:
    cs:
      locales:
        cs: { name: 'Čeština' }
        en: { name: 'Angličtina' }
    en:
      locales:
        cs: { name: 'Czech' }
        en: { name: 'English' }

  t: (key) ->

    uiLocale = 'en'

    if key
      bits = key.toString().split('.')
      context = I18n.translations[uiLocale]

      for bit in bits
        if context[bit]
          context = context[bit]
        else
          console.error "Missing key #{key}."
          return key

      context
    else
      console.error 'Missing translation key.'

window.I18n = I18n
