Meteor.publish "schema", ->
  DATA.find($or: [{_sid: "schema_key"}, {_sid: "doc_schema"}, {_sid: "doc_tag"}])
Meteor.publish "list", ->
  DATA.find($or: [
    {_sid: get_sid.currencies, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.titles, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.services, _kid: get_kid.doc_name, _root: {$exists: false}}
  ])
Meteor.publish "cities_list", (args) ->

  data  = DATA.find(
    {
      _sid: {$in: [get_sid.countries, get_sid.cities]}
      , _kid: get_kid.doc_name
      , _v: { $regex: args.input, $options: 'i' }
      , _root: {$exists: false}
    }, { limit: 5, fields: {_did: 1, _sid: 1} }
  ).fetch()
  n = 0
  country = []
  co = []
  while n < data.length
    if EJSON.equals(get_sid.cities, data[n]._sid)
      country[n] = DATA.findOne(_did: data[n]._did, _kid: get_kid.country)
      co[n] = DATA.findOne(_sid: get_sid.countries, _kid: get_kid.doc_name, _did: country[n]._v)

    else if EJSON.equals(get_sid.countries, data[n]._sid)
      country[n] = DATA.findOne(_did: data[n]._did, _kid: get_kid.capital)
      console.log country[n]
      h = DATA.findOne(_sid: get_sid.cities, _kid: get_kid.doc_name, _did: country[n]._v)
      if h
        co[n] = h
      console.log "countreis"
      console.log(co[n])
    n++
  console.log co
  c_id = _.pluck(country, '_id')
  co_id = _.pluck(co, '_id')
  ci_id = _.pluck(data, '_id')
  arr = c_id.concat(ci_id).concat(co_id)
  return DATA.find(_id: {$in: arr})
