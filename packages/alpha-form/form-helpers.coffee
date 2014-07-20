UI.registerHelper "t_data", ->
  if @_did
    return DATA.find({_id: @_did})
  return null

UI.registerHelper "make_href", ->
  if @href
    parent = UI._parentData(1)
    ini = Session.get("current_path")
    if ini
      num = parent.depth + 1
      arr = ini.split("/")
      arr.shift()
      len = arr.length
      arr.splice(num, len)
      str = arr.join("/")
    return "/#{str}#{@href}"
  return false

Template._string_select_options.helpers
  h_opt: ->
    parent = UI._parentData(2)
    return @[parent.key_key]

Template._each_input_master.helpers
  tri_gate: ->
    HUMAN_FORM.find(_pid: @_id, _s_n: "form_el")

Template._t_group.helpers
  t_gr: ->
    return LDATA.find(_gid: @_id, _s_n: "doc")

Template._t_space.helpers
  t_spa: ->
    return LDATA.find(_sid: @_id, _s_n: "_gr")

Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}

  t_yield: ->
    return LDATA.find(_pid: @_id, _s_n: "_spa")
  _sel_spa: ->
    if @_spa_tem and Template[@_spa_tem]
      return Template[@_spa_tem]
    return Template._t_space
  t_sub: ->
    id = Session.get("#{@_id}_path")
    return LDATA.find(_id: id, _s_n: "path")

Template.button_list.helpers
  schema_buttons: ->
    LDATA.find(_sid: @_id, _s_n: "_gr")

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
    sel = Session.get("#{parent._id}_sel_opt")
    if sel
      return LDATA.find({_gid: sel, _s_n: "doc"}, {sort: {sort: 1}})
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
    LDATA.find(_sid: @_id, _s_n: "_gr")
