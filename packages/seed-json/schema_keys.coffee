
fill_sid.init = ->
  DATA.find(_sid: "doc_schema").forEach (doc) ->
    get_sid[doc._v] = doc._id
  DATA.find(_sid: "schema_key").forEach (doc) ->
    get_kid[doc._v] = doc._id
  DATA.find(_sid: "doc_tag").forEach (doc) ->
    get_tid[doc._v] = doc._id