HUMAN_FORM = new Meteor.Collection(null, idGeneration: "MONGO")
CITIES = new Meteor.Collection(null, {idGeneration:"MONGO"})
HUMAN_B = new Meteor.Collection(null, {idGeneration:"MONGO"})


Deps.autorun ->
  if Session.equals("subscription", true)
    HUMAN_B.remove({})
    DATA.find(_sid: "doc_schema", _did: get_sid.humans, _req: {$exists: false}).forEach (doc) ->
      key = DATA.findOne(_id: doc._v)
      doc._skid = doc._id
      merge = _.extend(doc, key)
      HUMAN_B.insert(merge)
    HUMAN_FORM.remove({})
    DATA.find(_sid: "doc_schema", _did: get_sid.humans, _req: true).forEach (doc) ->
      key = DATA.findOne(_id: doc._v)
      doc._skid = doc._id
      merge = _.extend(doc, key)
      HUMAN_FORM.insert(merge)

Template.alpha_form.helpers
  schema_buttons: ->
    HUMAN_B.find({}, {sort: _sort: 1})
  input_element: ->
    HUMAN_FORM.find()
  _each_input: ->
    self = this
    if this._vt is "string"
      console.log self
      return UI.With (->
        console.log self
        return self
      ), Template._string_input
    else
      null
Template.alpha_form.events
  'click .click_input': (e, t) ->
    console.log this
    HUMAN_FORM.insert(this)
