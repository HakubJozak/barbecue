Barbecue.IsodateTransform = DS.DateTransform.extend
  serialize: (date) ->
    if date then moment(date).format("YYYY-MM-DD") else null
