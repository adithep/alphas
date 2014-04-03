class Schema_Keys
  constructor: (@schema_id, @key_id) ->
    @schema_id = {}
    @key_id = {}

  insert_schema_id: (name, id) ->
    @schema_id[name] = id

  insert_key_id: (name, id) ->
    @key_id[name] = id

  get_key_id: (name) ->
    if Object.keys(@key_id).length is 0 or not @key_id[name]
      DATA.find(_sid: "schema_key").forEach (doc) =>
        @key_id[doc.key_name] = doc._id
        return
    if @key_id[name]
      @key_id[name]
    else
      console.warn "no key #{name} in database"

  get_schema_id: (name) ->
    if Object.keys(@schema_id).length is 0 or not @schema_id[name]
      DATA.find(_sid: "doc_schema").forEach (doc) =>
        @schema_id[doc.doc_name] = doc._id
        return
    if @schema_id[name]
      @schema_id[name]
    else
      console.warn "no schema #{name} in database"

schema_keys = new Schema_Keys()