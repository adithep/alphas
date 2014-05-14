HUMAN_FORM = new Meteor.Collection(null, idGeneration: "MONGO")
CITIES = new Meteor.Collection(null, {idGeneration:"MONGO"})
HUMAN_B = new Meteor.Collection(null, {idGeneration:"MONGO"})

_each_dis = undefined

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
      merge._key = merge._id
      delete merge._id
      HUMAN_FORM.insert(merge)

Template.alpha_form.helpers
  schema_buttons: ->
    HUMAN_B.find({}, {sort: _sort: 1})
  input_element: ->
    HUMAN_FORM.find()
  _each_input: ->
    _each_dis = this
    if this._vt is "string"
      return UI.With (->
        return _each_dis
      ), Template._string_input
    else
      null

Template._schema_buttons.events
  'click .click_input': (e, t) ->
    self = EJSON.clone(t.data)
    self._key = self._id
    delete self._id
    if self._mtl
      HUMAN_FORM.insert(self)
    else if HUMAN_FORM.find(_key: self._key).count() is 0
      HUMAN_FORM.insert(self)
    else
      HUMAN_FORM.remove(_key: self._key)

    return
