UI.registerHelper "t_data", ->
  if @_did
    return DATA.find({_id: @_did})
  return null

Template._string_select_options.helpers
  h_opt: ->
    parent = UI._parentData(2)
    return @[parent.key_key]

Template._each_input_master.helpers
  tri_gate: ->
    HUMAN_FORM.find(_pid: @_id, _s_n: "form_el")

Template._t_content.helpers
  t_yield: ->
    gr = Session.get("current_session")
    if gr
      return LDATA.find(_gid: gr)
    return null

Template.button_list.helpers
  schema_buttons: ->
    parent = UI._parentData(1)
    sel = Session.get("#{parent._mid}_form_sel")
    LDATA.find(_lid: parent._mid, _cid: "input_form_btn", _gid: sel)

Template._parent_t.helpers

  t_tem: ->
    if @_tri_ty
      switch @_tri_ty
        when 'insert_form'
          return Template.insert_form
        when '_btn_list'
          return Template.button_list
        when '_btn'
          return Template._schema_buttons
        when 'input'
          return Template._each_input
    else
      return Template._string_select_options
    return null

Template._each_input.helpers
  input_value: ->
    parent = UI._parentData(1)
    return Session.get("#{parent._id}_v")
  class: ->
    str = ""
    if @class_n?
      str = "#{str} #{@class_n}"
    if @key_ty is "r_st"
      str = "#{str} input_select"
    if str?
      return str
  select_class: ->
    parent = UI._parentData(1)
    return Session.get("#{parent._id}_select_class")
  select_options: ->
    parent = UI._parentData(1)
    console.log parent
    sel = Session.get("#{parent._id}_sel_opt")
    console.log sel
    if sel
      return LDATA.find({_gid: sel}, {sort: {sort: 1}})
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
  attrs: ->
    return {class: @class_n}

Template.insert_form.helpers

  input_element: ->
    parent = UI._parentData(1)
    sel = Session.get("#{parent._mid}_form_sel")
    LDATA.find(_lid: parent._mid, _cid: "input_form_input", _gid: sel)
