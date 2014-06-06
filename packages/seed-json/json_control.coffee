fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')

json_control.printobj = ->
  ejson = EJSON.parse(Assets.getText('countries.json'))
  n = 0
  k = 0
  arr = []
  while n < ejson.length
    for key of ejson[n].translations
      arr[k] = {}
      arr[k].translations = true
      arr[k].trans_country_name = true
      arr[k].string = ejson[n].country_name
      arr[k].language = String(key)
      arr[k].translated_string = ejson[n].translations[key]
      k++
    n++

  h = '../../../../../../packages/seed-json/translations.json'
  fs.writeFileSync(
    h
    , EJSON.stringify(arr, {indent: true})
  )
  console.log arr

json_control.print = (json, type, array, name, arry, conv, cont, json2) ->
  ejson = EJSON.parse(Assets.getText(json))
  if json2
    ejson2 = EJSON.parse(Assets.getText(json2))
  n = 0
  k = 0
  arr = []
  while n < ejson.length
    nn = 0
    while nn < ejson[n][array].length
      arr[k] = {}
      arr[k][type] = true
      arr[k][name] = ejson[n][name]
      if conv and cont
        obj = {}
        obj[conv] = ejson[n][array][nn]
        console.log obj
        if ejson2
          ob = _.findWhere(ejson2, obj)
        else
          ob = _.findWhere(ejson, obj)
        if ob[cont]
          arr[k][arry] = ob[cont]
      else
        arr[k][arry] = ejson[n][array][nn]
      nn++
      k++
    n++
  h = '../../../../../../packages/seed-json/' + type + '.json'
  fs.writeFileSync(
    h
    , EJSON.stringify(arr, {indent: true})
  )
  console.log arr

json_control.insert_schema_keys = (j_k, json_s, json_k, json_t) ->
  json_s = json_s + ".json"
  json_k = json_k + ".json"
  json_t = json_t + ".json"
  j_k = j_k + ".json"
  schema = EJSON.parse(Assets.getText(json_s))
  schema_keys = EJSON.parse(Assets.getText(json_k))
  tags = EJSON.parse(Assets.getText(json_t))
  keys = EJSON.parse(Assets.getText(j_k))
  if schema and keys and schema_keys
    i_schema = 0
    i_keys = 0
    i_skeys = 0
    if tags and tags.length > 0
      i_tags = 0
      while i_tags < tags.length
        get_tid[tags[i_tags]._v] = DATA.insert(tags[i_tags])
        i_tags++
    while i_schema < schema.length
      get_sid[schema[i_schema]._v] = DATA.insert(schema[i_schema])
      i_schema++
    while i_keys < keys.length
      if keys[i_keys]._vs
        if keys[i_keys]._vs isnt "doc_schema" and keys[i_keys]._vs isnt "schema_key" and get_sid[keys[i_keys]._vs]
          keys[i_keys]._vs = get_sid[keys[i_keys]._vs]
      get_kid[keys[i_keys]._v] = DATA.insert(keys[i_keys])
      i_keys++

    while i_skeys < schema_keys.length
      if schema_keys[i_skeys]._kid
        if get_kid[schema_keys[i_skeys]._kid]
          schema_keys[i_skeys]._kid = get_kid[schema_keys[i_skeys]._kid]
        else
          console.warn "Cannot find Key #{schema_keys[i_skeys]._kid}"
      if schema_keys[i_skeys]._did
        if get_sid[schema_keys[i_skeys]._did]
          schema_keys[i_skeys]._did = get_sid[schema_keys[i_skeys]._did]
        else
          console.warn "Cannot find Schema #{schema_keys[i_skeys]._did}"
      if schema_keys[i_skeys]._v
        if get_kid[schema_keys[i_skeys]._v]
          schema_keys[i_skeys]._v = get_kid[schema_keys[i_skeys]._v]
        else
          console.warn "Cannot find Key #{schema_keys[i_skeys]._v}"

      if schema_keys[i_skeys]._tid
        if schema_keys[i_skeys]._tid.length > 0
          i_tid = 0
          while i_tid < schema_keys[i_skeys]._tid.length
            if get_tid[schema_keys[i_skeys]._tid[i_tid]]
              schema_keys[i_skeys]._tid[i_tid] = get_tid[schema_keys[i_skeys]._tid[i_tid]]
            else
              console.warn "No tag for #{schema_keys[i_skeys]._tid[i_tid]}"
            i_tid++
      DATA.insert(schema_keys[i_skeys])
      i_skeys++

    console.log "#{json_k} inserted"
  else
    console.warn "Cannot find or parse Json Files"
  return

while_loop = (array, obj) ->
  i = 0
  j = 0
  arr = []
  while i < array.length
    if obj[array[i]]
      arr[j] = obj[array[i]]
      j++
    else
      console.warn "no key for #{obj[array[i]]}"
    i++
  arr

value_type = (value, key) ->
  if key and value
    switch key._vt
      when "string"
        if String(value) isnt ""
          return String(value)
      when "number"
        if Number(value) isnt NaN
          return Number(value)
      when "oid"
        doc = DATA.findOne(_sid: key._vs, _v: value, _kid: get_kid.doc_name)
        if doc
          return doc._did
        else
          console.warn "cannot find id for #{value}"
          return String(value)
      when "boolean"
        if typeof value is "bolean"
          return value
      when "currency"
        if Number(value) isnt NaN
          return Number(value)
      when "phone"
        phone = phone_format.format_number(value)
        if phone
          return phone
      when "email"
        if email_format.reg.test(value)
          return value
      when "date"
        if value instanceof Date
          return value
  false

array_loop = (array, key, key_id, oid, schema) ->
  ine = 0
  while ine < array.length
    if Array.isArray(array[ine])
      array_loop(array[ine], key)
    else
      value = value_type(array[ine], key)
      if value
        DATA.insert
          _kid: key_id
          , _did: oid
          , _sid: schema
          , _v: value
          , _usr: "server"
          , _dte: new Date()
      else
        console.warn "invalid value #{array[ine]}"
    ine++

json_control.insert_json = (json, schema) ->
  json = json + ".json"
  json_obj = EJSON.parse(Assets.getText(json))
  if json_obj and json_obj.length > 0 and schema
    i = 0
    while i < json_obj.length
      obj_keys = Object.keys(json_obj[i])
      i_obj = 0
      oid = DATA.insert(_sid: schema, _root: true)
      while i_obj < obj_keys.length
        key_id = get_kid[obj_keys[i_obj]]
        if key_id
          s_key = DATA.findOne
            _v: key_id
            , _did: schema
            , _sid: "doc_schema"
            , _kid: get_kid.key
          key_obj = DATA.findOne(_id: key_id)
          if s_key and key_obj
            if s_key._mtl or DATA.find(
              _kid: key_id
              , _did: oid
              , _sid: schema
            ).count() is 0
              if json_obj[i][obj_keys[i_obj]]
                if Array.isArray(json_obj[i][obj_keys[i_obj]])
                  array_loop(
                    json_obj[i][obj_keys[i_obj]]
                    , key_obj
                    , key_id
                    , oid
                    , schema)
                else
                  value = value_type(json_obj[i][obj_keys[i_obj]], key_obj)
                  if value
                    DATA.insert
                      _kid: key_id
                      , _did: oid
                      , _sid: schema
                      , _v: value
                      , _usr: "server"
                      , _dte: new Date()
                  else
                    console.warn "invalid value #{obj_keys[i_obj]}"
              else
                console.warn "invalid or blank value #{obj_keys[i_obj]}"
            else
              console.warn "multiple value of #{obj_keys[i_obj]} not allowed"
          else
            console.warn "cannot find key #{obj_keys[i_obj]}"
        else
          console.warn "could not find key #{obj_keys[i_obj]}"
        i_obj++
      i++

  else
    console.warn "Cannot find or parse Json File: #{json}"
  return
