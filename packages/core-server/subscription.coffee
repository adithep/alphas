Meteor.publish "schema", ->
  DATA.find($or: [{_sid: "schema_key"}, {_sid: "doc_schema"}, {_sid: "doc_tag"}])
Meteor.publish "list", ->
  DATA.find($or: [
    {_sid: get_sid.countries, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.currencies, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.titles, _kid: get_kid.doc_name, _root: {$exists: false}},
    {_sid: get_sid.services, _kid: get_kid.doc_name, _root: {$exists: false}}
  ])
