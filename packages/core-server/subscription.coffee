Meteor.publish "list", ->
  DATA.find({
    _s_n: {$in: [
      "keys"
      "countries"
      "titles"
      "currencies"
      "service_n"
      "_tri"
      "tags"
    ]}
  }, {fields: {_dt: 0}})
