Meteor.publish "list", ->
  DATA.find({
    _s_n: {$in: [
      "keys"
      "countries"
      "titles"
      "currencies"
      "input_forms"
      "service_n"
      "_tri"
      "_spa"
      "paths"
      "tags"
    ]}
  }, {fields: {_dt: 0}})
