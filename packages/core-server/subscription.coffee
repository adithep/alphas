Meteor.publish "list", ->
  DATA.find({
    _s_n: {$in: [
      "_s"
      "keys"
      "countries"
      "titles"
      "currencies"
      "services"
      "_tri"
      "tags"
    ]}
  }, {fields: {_dt: 0}})
