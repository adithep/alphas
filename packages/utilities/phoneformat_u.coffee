phone_format.format_number = (number, country) ->
  if number.substring(0, 1) is "+"
    country_code = number.substring(1, 2)
  else
    country_code = number.substring(0, 2)
    doc_id = DATA.findOne(value: country_code, _kid: get_kid.calling_code)
    if doc_id
      cca2 = DATA.findOne(_did: doc_id._did, _kid: get_kid.cca2)
      if phone_format.isValidNumber(number, cca2.value)
        return number
    else

 
