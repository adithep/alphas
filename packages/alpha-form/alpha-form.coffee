HUMAN_FORM = new Meteor.Collection(null)
CITIES = new Meteor.Collection(null)

_each_dis = undefined


Template._string_select.helpers
  select_options: ->
    DATA.find(_sid: this._vs, _kid: get_kid.doc_name)

Template._string_input.helpers
  aselect: ->
    CITIES.find()

Template._schema_buttons.helpers
  get_key_dis: ->
    a = DATA.findOne(_s_n: "keys", key_n: this._tri_dis)
    return a.key_dis

Template.alpha_form.helpers

  schema_buttons: ->
    DATA.find(_s_n: "_tri", _tri_gr: "_get_human_buttons")

  input_element: ->
    HUMAN_FORM.find()
