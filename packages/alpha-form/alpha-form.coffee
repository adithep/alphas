HUMAN_FORM = new Meteor.Collection(null)
CITIES = new Meteor.Collection(null)

_each_dis = undefined

Deps.autorun ->
  if Session.equals("subscription", true)
    h = DATA.find(
      _s_n: "_tri"
      , form_collection: "HUMAN_INPUT"
      , _tri_starting: true
    ).forEach (doc) ->
      tri = {}
      tri._tri = [doc]
      HUMAN_FORM.insert(tri)

Template._string_select.helpers
  select_options: ->
    tmpl = UI._templateInstance()
    id = tmpl.__component__.guid
    te = "input-#{id}"
    text = Session.get(te)
    if text?
      obj = {}
      obj._s_n = this.key_s
      obj[this.key_key] = { $regex: text, $options: 'i' }
      arr1 = DATA.find(obj, {limit: 5}).fetch()
      if arr1.length < 5
        len = 5 - arr1.length
        first_c = text.substr(0,1)
        obj[this.key_key] = { $regex: first_c, $options: 'i' }
        ids = _.pluck(arr1, "_id")
        obj._id = {$nin: ids}
        arr2 = DATA.find(obj, {limit: len}).fetch()
        arr1 = arr1.concat(arr2)
        if arr1.length < 5
          len = 5 - arr1.length
          ids = _.pluck(arr1, "_id")
          obj._id = {$nin: ids}
          delete obj[this.key_key]
          arr3 = DATA.find(obj, {limit: len}).fetch()
          arr1 = arr1.concat(arr3)
          return arr1
        else
          return arr1
      else
        return arr1
    else
      return DATA.find({_s_n: this.key_s}, {limit: 5})
  select_value: ->
    tmpl = UI._templateInstance()
    id = tmpl.__component__.guid
    te = "input-#{id}"
    a = DATA.findOne(_s_n: this.key_s)
    if a?
      Session.set(te, a[this.key_key])
      return a[this.key_key]
    else
      return

Template._string_select_options.helpers
  h_opt: ->
    parent = UI._parentData(1)
    return this[parent.key_key]

Template._string_input.helpers
  input_type: ->
    switch this.key_ty
      when "_dt"
        return "date"
      when "email"
        return "email"
      else
        return "text"

Template._each_input.helpers
  tmpl: ->
    if this._tri_dis
      key = DATA.findOne(_s_n: "keys", key_n: this._tri_dis)
      if key?
        switch key.key_ty
          when "r_st"
            return "_string_select"
          else
            return "_string_input"
  tmpl_data: ->
    DATA.findOne(_s_n: "keys", key_n: this._tri_dis)

Template._schema_buttons.helpers
  get_key_dis: ->
    DATA.find(_s_n: "keys", key_n: this._tri_dis)

Template.alpha_form.helpers

  schema_buttons: ->
    DATA.find({_s_n: "_tri", _tri_gr: "_get_human_buttons"}, {sort: {sort: 1}})

  input_element: ->
    HUMAN_FORM.find()

Template._each_input_master.events
  'click span.s_liga': (e, t) ->
    HUMAN_FORM.remove(_id: t.data._id)

Template._string_select.events
  'focus .input_select': (e, t) ->
    t.$('.div_select').addClass('show')
  'blur .input_select': (e, t) ->
    t.$('.div_select').removeClass('show')
  'keyup .input_select': (e, t) ->

    a = UI.DomRange.getContainingComponent(e.currentTarget)
    te = "input-#{a.guid}"
    Session.set(te, e.currentTarget.value)

Template._schema_buttons.events
  'click ._get': (e, t) ->
    if this.on_click
      obj = {}
      obj._tri = []
      n = 0
      tri = DATA.find(_s_n: "_tri", _tri_gr: this.on_click).forEach (doc) ->
        obj._tri[n] = doc
        n++
      if obj._tri.length > 1
        HUMAN_FORM.insert(obj)
      else if obj._tri.length is 1
        if HUMAN_FORM.find(_tri: obj._tri).count() > 0
          HUMAN_FORM.remove(_tri: obj._tri)
        else
          HUMAN_FORM.insert(obj)
