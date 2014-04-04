json_control.insert_schema_keys = (json_s, json_k) ->
  json_s = json_s + ".json"
  json_k = json_k + ".json"
  schema = EJSON.parse(Assets.getText(json_s))
  schema_keys = EJSON.parse(Assets.getText(json_k))
  if schema.length > 0 and schema_keys.length > 0
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