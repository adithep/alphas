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
  select_options: (id) ->
    console.log this
    te = "input-#{id}"
    text = Session.get(te)
    if text?
      obj = {}
      obj._s_n = this.key_s
      obj[this.key_key] = { $regex: text, $options: 'i' }
      return DATA.find(obj, {limit: 5})
    else
      return DATA.find({_s_n: this.key_s}, {limit: 5})
  select_value: ->
    a = DATA.findOne(_s_n: this.key_s)
    return a[this.key_key]

Template._string_select_options.helpers
  h_opt: (key_key) ->
    return this[key_key]

Template._string_input.helpers
  input_type: ->
    switch this.key_ty
      when "_st"
        return "text"
      when "_num"
        return "number"
      when "_dt"
        return "date"
      when "email"
        return "email"
      when "phone"
        return "text"
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

Template._string_select.events
  'focus .input_select': (e, t) ->
    t.$('.div_select').addClass('show')
  'blur .input_select': (e, t) ->
    t.$('.div_select').removeClass('show')

Template._each_input_master.events
  'keyup .input_select': (e, t) ->
    this.__value = e.currentTarget.value
    te = "input-#{t.data._id}"
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
      HUMAN_FORM.insert(obj)
