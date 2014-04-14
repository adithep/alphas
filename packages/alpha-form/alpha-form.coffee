HUMAN_FORM = new Meteor.Collection(null, idGeneration: "MONGO")
CITIES = new Meteor.Collection(null, {idGeneration:"MONGO"})
HUMAN_B = new Meteor.Collection(null, {idGeneration:"MONGO"})

Deps.autorun ->
  if Session.equals("subscription", true)
    HUMAN_B.remove({})
    DATA.find(_sid: "doc_schema", _did: get_sid.humans, _req: {$exists: false}).forEach (doc) ->
      key = DATA.findOne(_id: doc._v)
      HUMAN_B.insert(key)

Template.alpha_form.helpers
  schema_buttons: ->
    HUMAN_B.find({}, {sort: _sort: 1})
