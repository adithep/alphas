json_control.insert_schema_keys = (json_s, json_k, json_t) ->
  json_s = json_s + ".json"
  json_k = json_k + ".json"
  json_t = json_t + ".json"
  schema = EJSON.parse(Assets.getText(json_s))
  schema_keys = EJSON.parse(Assets.getText(json_k))
  tags = EJSON.parse(Assets.getText(json_t))
  if schema and schema_keys and schema.length > 0 and schema_keys.length > 0
    i_schema = 0
    i_keys = 0
    i_tags = 0
    if tags and tags.length > 0
      while i_tags < tags.length
        get_tid[tags[i_tags].doc_name] = DATA.insert(tags[i_tags])
        i_tags++
    while i_keys < schema_keys.length
      get_kid[schema_keys[i_keys].key_name] = DATA.insert(schema_keys[i_keys])
      i_keys++
    while i_schema < schema.length
      if schema[i_schema]._kids
        if schema[i_schema]._kids.length > 0
          schema[i_schema]._kids = while_loop(schema[i_schema]._kids, get_kid)
      if schema[i_schema]._mids
        if schema[i_schema]._mids.length > 0
          schema[i_schema]._mids = while_loop(schema[i_schema]._mids, get_kid)
      if schema[i_schema]._dids
        if schema[i_schema]._dids.length > 0
          schema[i_schema]._dids = while_loop(schema[i_schema]._dids, get_sid)
      if schema[i_schema]._tids
        if schema[i_schema]._tids.length > 0
          i_tid = 0
          while i_tid < schema[i_schema]._tids.length
            schema[i_schema]._tids[i_tid].key = get_kid[schema[i_schema]._tids[i_tid].key]
            schema[i_schema]._tids[i_tid].tags = while_loop(schema[i_schema]._tids[i_tid].tags, get_tid)
            i_tid++
      schema_id = DATA.insert(schema[i_schema])
      get_sid[schema[i_schema].doc_name] = schema_id
      i_schema++
        

    DATA.find({_sid: "schema_key", value_schema: {$exists: true}}).forEach (doc) ->
      if doc.value_schema and doc.value_schema isnt "doc_schema" and doc.value_schema isnt "schema_key"
        DATA.update({_id: doc._id}, {$set: {value_schema: get_sid[doc.value_schema]}})

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

ejson_equals = (array, value) ->
  i = 0
  while i < array.length
    if EJSON.equals(array[i], value)
      return true
    i++
  false

json_control.insert_json = (json, schema) ->
  json = json + ".json"
  json_obj = EJSON.parse(Assets.getText(json))
  if json_obj and json_obj.length > 0
    schema_doc = DATA.findOne(_id: schema)
    if schema_doc
      console.log schema_doc
      i = 0
      while i < json_obj.length
        obj_keys = Object.keys(json_obj[i])
        i_obj = 0
        oid = DATA.insert(_sid: schema_doc._id)
        while i_obj < obj_keys.length
          key_id = get_kid[obj_keys[i_obj]]
          if key_id
            if schema_doc._kids and schema_doc._mids
              s_arr = schema_doc._kids.cocat(schema_doc._mids)
            else if schema_doc._kids
              s_arr = schema_doc._kids
            else if schema_doc._mids
              s_arr = schema_doc._mids
            if ejson_equals(s_arr, key_id)
              key_obj = DATA.findOne(_id: key_id)
              if key_obj and json_obj[i][obj_keys[i_obj]]
                switch key_obj.value_type
                  when "string"
                    value_t = String(json_obj[i][obj_keys[i_obj]])
                    if typeof value_t is "string"
                      value = value_t
                  when "number"
                    value_t = Number(json_obj[i][obj_keys[i_obj]])
                    if typeof value_t is "number"
                      value = value_t
                  when "oid"
                    doc = DATA.findOne(_sid: key_obj.value_schema, value: json_obj[i][obj_keys[i_obj]], _kid: get_kid.doc_name)
                    if doc
                      value = doc._id
                    else
                      console.warn "cannot find id for #{json_obj[i][obj_keys[i_obj]]}"
                  when "boolean"
                    if typeof json_obj[i][obj_keys[i_obj]] is "bolean"
                      value = json_obj[i][obj_keys[i_obj]]
                  when "currency"
                    value_t = Number(json_obj[i][obj_keys[i_obj]])
                    if typeof value_t is "number"
                      value = value_t
                  when "phone"
                    if json_obj[i][obj_keys[i_obj]].substring(0, 1) is "+"
                      country_code = json_obj[i][obj_keys[i_obj]].substring(1, 2)
                      doc_id = DATA.findOne(value: country_code, _kid: get_kid.calling_code)
                      cca2 = DATA.findOne(_did: doc_id._did, _kid: get_kid.cca2)
                      if phone_format.isValidNumber(json_obj[i][obj_keys[i_obj]], cca2.value)
                        value = json_obj[i][obj_keys[i_obj]]
                  when "email"
                    if email_format.reg.test(json_obj[i][obj_keys[i_obj]])
                      value = json_obj[i][obj_keys[i_obj]]
                  when "date"
                    if json_obj[i][obj_keys[i_obj]] instanceof Date
                      value = json_obj[i][obj_keys[i_obj]]
                if value
                  DATA.insert(_kid: key_obj._id, _did: oid, _sid: schema_doc._id, value: value, _mod: [{user: "server", date: new Date()}])
                else
                  console.warn "invalid value #{obj_keys[i_obj]}"
              else
                console.warn "could not find key #{obj_keys[i_obj]}"
            else
              console.warn "key #{obj_keys[i_obj]} not allowed"
          else
            console.warn "could not find key #{obj_keys[i_obj]}"

          i_obj++
        i++
    else
      console.warn "Cannot find schema: #{schema}"

  else
    console.warn "Cannot find or parse Json File: #{json}"
  return
