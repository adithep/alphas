json_control.insert_schema_keys = (json_s, json_k) ->
  json_s = json_s + ".json"
  json_k = json_k + ".json"
  schema = EJSON.parse(Assets.getText(json_s))
  schema_keys = EJSON.parse(Assets.getText(json_k))
  if schema and schema_keys and schema.length > 0 and schema_keys.length > 0
    i_schema = 0
    i_keys = 0
    while i_keys < schema_keys.length
      key_id = DATA.insert(schema_keys[i_keys])
      schema_obj.key_id[schema_keys[i_keys].key_name] = key_id
      i_keys++
    while i_schema < schema.length
      i_kids = 0
      i_dids = 0
      _kids = schema[i_schema]._kids
      _dids = schema[i_schema]._dids
      if _kids and _kids.length > 0
        while i_kids < _kids.length
          _kid = schema_obj.key_id[_kids[i_kids]]
          schema[i_schema]._kids[i_kids] = _kid
          i_kids++
      if _dids and _dids.length > 0
        while i_dids < _dids.length
          _did = schema_obj.schema_id[_dids[i_dids]]
          schema[i_schema]._dids[i_dids] = _did
          i_dids++
      schema_id = DATA.insert(schema[i_schema])
      schema_obj.schema_id[schema[i_schema].doc_name] = schema_id
      i_schema++
      

    DATA.find({_sid: "schema_key", $or: [{value_schema: {$exists: true}}, {array_values_schema: {$exists: true}}]}).forEach (doc) ->
      if doc.value_schema and doc.value_schema isnt "doc_schema" and doc.value_schema isnt "schema_key"
        DATA.update({_id: doc._id}, {$set: {value_schema: schema_obj.schema_id[doc.value_schema]}})
      if doc.array_values_schema and doc.array_values_schema isnt "doc_schema" and doc.array_values_schema isnt "schema_key"
        DATA.update({_id: doc._id}, {$set: {array_values_schema: schema_obj.schema_id[doc.array_values_schema]}})

    console.log "#{json_k} inserted"
  else
    console.warn "Cannot find or parse Json Files"
  return

json_control.insert_json = (json, schema) ->
  json = json + ".json"
  json_obj = EJSON.parse(Assets.getText(json))
  if json_obj and json_obj.length > 0
    schema_doc = DATA.fineOne(_sid: "doc_schema", doc_name: schema)
    if schema_doc
      i = 0
      while i < json_obj.length
        obj_keys = Object.keys(json_obj[i])
        i_obj = 0
        oid = DATA.insert(_sid: schema_doc._id)
        while i_obj < obj_keys.length
          key_id = schema_obj.key_id[obj_keys[i_obj]]
          if key_id
            if schema_doc._kids.indexOf(key_id) isnt -1
              key_obj = DATA.fineOne(_id: key_id)
              if key_obj
                switch key_obj.value_type
                  when "string"
                    value = String(json_obj[i][obj_keys[i_obj]])
                  when "number"
                    value = Number(json_obj[i][obj_keys[i_obj]])
                  when "oid"
                    doc = DATA.fineOne(_sid: key_obj.value_schema, doc_name: json_obj[i][obj_keys[i_obj]])
                    value = doc._id
                  when "boolean"
                    if typeof json_obj[i][obj_keys[i_obj]] is "bolean"
                      value = json_obj[i][obj_keys[i_obj]]

                date = new Date()
                DATA.insert(_kid: key_obj._id, _did: oid, value: value, _modified: [{system: date}])
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
