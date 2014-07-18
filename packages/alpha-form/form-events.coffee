

Template._string_select_options.events

  'click .select_option': (e, t) ->
    parent = get_parent_data(t, 3)
    cl = Session.get("#{parent._id}_select_class")
    if cl is "show"
      Session.set("#{parent._id}_select_class", false)
    else if cl and cl.indexOf("show") isnt -1
      cl = cl.replace("show", "")
      Session.set("#{parent._id}_select_class", cl)
    tri = DATA.findOne(_id: parent._did)
    unless Session.equals("#{parent._id}_v", @[tri.key_key])
      Session.set("#{parent._id}_v", @[tri.key_key])

  'mouseenter a.select_option': (e, t) ->
    if not @class or @class isnt "glow"
      HUMAN_FORM.update({
        _s_n: "form_sel"
        , _sel_id: @_sel_id}, {$unset: {class: ""}}, {multi: true})
      HUMAN_FORM.update({
        _s_n: "form_sel"
        , _id: @_id}, {$set: {class: "glow"}})



Template._each_input.events

  'click span.s_liga': (e, t) ->
    parent = get_parent_data(t)
    LDATA.remove($or:[{_id: parent._gid}, {_gid: parent._gid}])

  'mouseenter .div_select': (e, t) ->
    parent = get_parent_data(t)
    if Session.equals("#{parent._id}_select_class", "show")
      Session.set("#{parent._id}_mov", true)
    else
      cl = Session.get("#{parent._id}_select_class")
      if cl and cl.indexOf("show") isnt -1
        Session.set("#{parent._id}_mov", true)

  'mouseleave .div_select': (e, t) ->
    parent = get_parent_data(t)
    Session.set("#{parent._id}_mov", false)

  'focus .input_select': (e, t) ->
    parent = get_parent_data(t)
    a = ->
      e.currentTarget.select()
    Meteor.setTimeout(a, 20)
    cl = Session.get("#{parent._id}_select_class")
    unless cl
      cl = "show"
      Session.set("#{parent._id}_select_class", cl)
    else if cl and cl.indexOf("show") is -1
      cl = cl + " show"
      Session.set("#{parent._id}_select_class", cl)

  'blur input.input_select': (e, t) ->
    parent = get_parent_data(t)
    if Session.equals("#{parent._id}_mov", false)
      cl = Session.get("#{parent._id}_select_class")
      if cl is "show"
        Session.set("#{parent._id}_select_class", false)
      else if cl and cl.indexOf("show") isnt -1
        cl = cl.replace("show", "")
        Session.set("#{parent._id}_select_class", cl)
    unless Session.equals("#{parent._id}_v", e.currentTarget.value)
      v = Session.get("#{parent._id}_v")
      e.currentTarget.value = v
  'blur input.input_ui:not(.input_select)': (e, t) ->
    parent = get_parent_data(t)
    unless Session.equals("#{parent._id}_v", e.currentTarget.value)
      Session.set("#{parent._id}_v", e.currentTarget.value)

Template._schema_buttons.events

  'click ._get': (e, t) ->
    parent = get_parent_data(t)
    sela = Session.get("#{parent._pid}_input_gr")
    if @on_click
      obj = {}
      pa = "_tri_grs.#{@on_click}"
      obj[pa] = {$exists: true}
      obj._s_n = "_tri"
      if DATA.find(obj).count() > 1
        human_form_insert(@on_click, parent, sela)
      else
        if LDATA.find(_gr: @on_click, _sid: sela).count() is 0
          human_form_insert(@on_click, parent, sela)
        else
          id = LDATA.findOne(_gr: @on_click, _sid: sela)
          LDATA.remove($or:[{_id: id._id}, {_gid: id._id}])
