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

  translate: (key) ->
    if key
      bits = key.toString().split('.')
      context = I18n.translations[I18n.locale]

      for bit in bits
        if context[bit]
          context = context[bit]
        else
          console.error "Missing key '#{key}'."
          return key

      context
    else
      console.error 'Missing translation key.'

# alias
I18n.t = ->
  I18n.translate.apply(this,arguments)      

window.I18n = I18n
