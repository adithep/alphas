class Json_Control
  
  insert_schema_keys: (json_s, json_k) ->
    json_s = json_s + ".json"
    json_k = json_k + ".json"
    schema = EJSON.parse(Assets.getText(json_s))
    schema_keys = EJSON.parse(Assets.getText(json_k))
    if schema.length > 0 and schema_keys.lenght > 0
      i_schema = 0, i_keys =0, i_kids = 0, i_dids = 0
      while i_keys < schema_keys.length
        key_id = DATA.insert(schema_keys[i_keys])
        schema_keys.insert_key_id(key_id, schema_keys[i_keys].key_name)
        i_keys++
      while i_schema < schema.length
        _kids = schema[i_schema]._kids
        _dids = schema[i_schema]._dids
        if _kids.length > 0
          while i_kids < _kids.length
            _kid = schema_keys.get_key_id(_kids[i_kids])
            schema[i_schema]._kids[i_kids] = _kid
            i_kids++
        if _dids.length > 0
          while i_dids < _dids.length
            _did = schema_keys.get_schema_id(_dids[i_dids])
            schema[i_schema]._dids[i_dids] = _did
            i_dids++
        schema_id = DATA.insert(schema[i_schema])

      DATA.find({_sid: "schema_keys", $or[value_schema: {$exists: true}, value_array_schema: {$exists: true}]})

      console.log "#{json_k} inserted"
    else
      console.warn "Cannot find or parse Json Files"
    return


json_control = new Json_Control()