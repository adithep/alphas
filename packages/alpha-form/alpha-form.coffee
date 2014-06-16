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
    DATA.find(_s_n: this.key_s)

Template._string_select_options.helpers
  h_opt: (key_key) ->
    return this[key_key]

Template._each_input_master.helpers
  kab: ->
    console.log this

Template._each_input.helpers
  tmpl: ->
    if this._tri_dis
      key = DATA.findOne(_s_n: "keys", key_n: this._tri_dis)
      if key?
        switch key.key_ty
          when "_st"
            return "_string_input_text"
          when "r_st"
            return "_string_select"
          when "_num"
            return "_string_input_number"
          when "_dt"
            return "_string_input_date"
          when "email"
            return "_string_input_email"
          when "phone"
            return "_string_input_text"
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

Template._schema_buttons.events
  'click ._get': (e, t) ->
    if this.on_click
      console.log this
      obj = {}
      obj._tri = []
      n = 0
      tri = DATA.find(_s_n: "_tri", _tri_gr: this.on_click).forEach (doc) ->
        obj._tri[n] = doc
        n++
      HUMAN_FORM.insert(obj)
