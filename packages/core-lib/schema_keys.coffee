

schema_obj.find_keys = ->
  if Object.keys(schema_obj.schema_id).length is 0
    DATA.find(_sid: "doc_schema").forEach (doc) ->
      schema_obj.schema_id[doc.doc_name] = doc._id
  if Object.keys(schema_obj.key_id).length is 0
    DATA.find(_sid: "schema_key").forEach (doc) ->
      schema_obj.key_id[doc.key_name] = doc._id