HUMAN_FORM = new Meteor.Collection(null, idGeneration: "MONGO")
CITIES = new Meteor.Collection(null, {idGeneration:"MONGO"})
HUMAN_B = new Meteor.Collection(null, {idGeneration:"MONGO"})

_each_dis = undefined

Deps.autorun ->
  if Session.equals("subscription", true)
    HUMAN_B.remove({})
    DATA.find(
      _sid: "doc_schema"
      , _did: get_sid.humans
      , _req: {$exists: false}
    ).forEach (doc) ->
      key = DATA.findOne(_id: doc._v)
      doc._skid = doc._id
      merge = _.extend(doc, key)
      HUMAN_B.insert(merge)
    HUMAN_FORM.remove({})
    DATA.find(
      _sid: "doc_schema"
      , _did: get_sid.humans
      , _req: true
    ).forEach (doc) ->
      key = DATA.findOne(_id: doc._v)
      doc._skid = doc._id
      merge = _.extend(doc, key)
      merge._key = merge._id
      delete merge._id
      HUMAN_FORM.insert(merge)

Template._string_select.helpers
  select_options: ->
    DATA.find(_sid: this._vs, _kid: get_kid.doc_name)

Template._string_input.helpers
  aselect: ->
    CITIES.find()



Template.alpha_form.helpers
  schema_buttons: ->
    HUMAN_B.find({}, {sort: _sort: 1})
  input_element: ->
    HUMAN_FORM.find()
  _each_input: ->
    _each_dis = this
    if this._vt is "string"
      _each_dis.type = "text"
      return UI.With (->
        return _each_dis
      ), Template._string_input
    else if this._vt is "email"
      _each_dis.type = "text"
      return UI.With (->
        return _each_dis
      ), Template._string_input
    else if this._vt is "date"
      _each_dis.type = "date"
      return UI.With (->
        return _each_dis
      ), Template._string_input
    else if this._vt is "phone"
      _each_dis.type = "text"
      return UI.With (->
        return _each_dis
      ), Template._string_input
    else if this._vt is "oid"
      if this._new
        null
      else if this._big
        _each_dis.class = "input_subscribe"
        return UI.With (->
          return _each_dis
        ), Template._string_input
      else
        return UI.With (->
          return _each_dis
        ), Template._string_select
    else
      null

Template.alpha_form.events
  'keypress form': (e, t) ->
    if e.which is 13
      e.preventDefault()


Template._string_input.events

  'focus .input_subscribe': (e, t) ->
    t.$('.adropdown').addClass('show')

  'blur .input_subscribe': (e, t) ->
    t.$('.adropdown').removeClass('show')

  'keyup .input_subscribe': (e, t) ->

    if e.currentTarget.value isnt ""

      params = {input: e.currentTarget.value, field: this._sid}

      Meteor.subscribe "cities_list", params, ->
        CITIES.remove({})
        DATA.find(
          {$and: [
            _sid: {$in: [get_sid.countries, get_sid.cities]}
            , _kid: get_kid.doc_name
            , _v: { $regex: e.currentTarget.value, $options: 'i' }
          ]}, { limit: 5 }
        ).forEach (doc) ->
          if EJSON.equals(get_sid.cities, doc._sid)
            c_i = DATA.findOne(_did: doc._did, _kid: get_kid.country)
            if c_i
              country = DATA.findOne(_did: c_i._v, _kid: get_kid.doc_name)
              CITIES.insert({city: doc, country: country})

          else if EJSON.equals(get_sid.countries, doc._sid)
            c_i = DATA.findOne(_did: doc._did, _kid: get_kid.capital)
            if c_i
              city = DATA.findOne(_did: c_i._v, _kid: get_kid.doc_name)
              CITIES.insert({country: doc, city: city})

      return

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
