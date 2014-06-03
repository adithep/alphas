Meteor.publish "schema", ->
  DATA.find
    $or: [
      {_sid: "schema_key"}
      , {_sid: "doc_schema"}
      , {_sid: "doc_tag"}
    ]

Meteor.publish "list", ->
  DATA.find({$or: [
    {_sid: get_sid.currencies, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.titles, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.services, _kid: get_kid.doc_name, _root: {$exists: false}}
  ]}, {fields: {_dte: 0, _usr: 0}})

Meteor.publish "cities_list", (args) ->
  did = []
  n = 0
  data  = DATA.find(
    {
      _sid: {$in: [get_sid.countries, get_sid.cities]}
      , _kid: get_kid.doc_name
      , _v: { $regex: args.input, $options: 'i' }
      , _root: {$exists: false}
    }, { limit: 5, fields: {_did: 1, _sid: 1, _v: 1} }
  ).forEach (doc) ->
    did[n++] = doc._did
    if EJSON.equals(get_sid.cities, doc._sid)
      country = DATA.findOne
        _sid: get_sid.cities
        , _kid: get_kid.country
        , _did: doc._did
      did[n++] = country._v
      capital = DATA.findOne
        _sid: get_sid.countries
        , _kid: get_kid.capital
        , _did: country._v
      did[n++] = capital._v
    else if EJSON.equals(get_sid.countries, doc._sid)
      capital = DATA.findOne
        _sid: get_sid.countries
        , _kid: get_kid.capital
        , _did: doc._did
      did[n++] = capital._v

  return DATA.find(
    {
      _sid: {$in: [get_sid.cities, get_sid.countries]}
      , _kid: {$in: [get_kid.doc_name, get_kid.capital, get_kid.country]}
      , _did: {$in: did}
    }, {fields: {_dte: 0, _usr: 0}}
  )
