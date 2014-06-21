Template._string_select.helpers

  select_value: ->
    a = DATA.findOne(_s_n: @key_s)
    parent = UI._parentData(3)
    if a?
      return a[@key_key]
    else
      return

Template._string_select_options.helpers
  h_opt: ->
    parent = UI._parentData(1)
    return this[parent.key_key]

Template._string_input.helpers
  input_type: ->
    switch @key_ty
      when "_dt"
        return "date"
      when "email"
        return "email"
      else
        return "text"

Template._each_input_master.helpers
  tri_gate: ->
    HUMAN_FORM.find(_pid: @_id, _s_n: "form_el")



Template._each_input.helpers
  class: ->
    str = ""
    if @class_n?
      str = "#{str} #{@class_n}"
    if @key_ty is "r_st"
      str = "#{str} input_select"
    if str?
      return str
  select_options: ->
    HUMAN_FORM.find({_s_n: "form_sel", _sel_id: @_id}, {sort: {sort: 1}})
  select_value: ->
    if @_v
      return @_v
    else if not @_v?
      a = HUMAN_FORM.findOne({
        _s_n: "form_sel"
        , _sel_id: @_id
        , sort: 0})
      if a
        return a[@key_key]

    return

Template._schema_buttons.helpers
  get_key_dis: ->
    DATA.find(_s_n: "keys", key_n: @_tri_dis)

Template.alpha_form.helpers

  schema_buttons: ->
    DATA.find({_s_n: "_tri", _tri_gr: "_get_human_buttons"}, {sort: {sort: 1}})

  input_element: ->
    HUMAN_FORM.find(_s_n: "form_gr")