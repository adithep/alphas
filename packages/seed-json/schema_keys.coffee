
fill_sid.init = ->
  DATA.find(_sid: "doc_schema").forEach (doc) ->
    get_sid[doc.doc_name] = doc._id
  DATA.find(_sid: "schema_key").forEach (doc) ->
    get_kid[doc.key_name] = doc._id
  DATA.find(_sid: "doc_tag").forEach (doc) ->
    get_tid[doc.doc_name] = doc._id