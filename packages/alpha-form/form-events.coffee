Template._parent_t.events

  'click .select_option': (e, t) ->
    cl = Session.get("#{t.data._id}_select_class")
    if cl is "show"
      Session.set("#{t.data._id}_select_class", false)
    else if cl and cl.indexOf("show") isnt -1
      cl = cl.replace("show", "")
      Session.set("#{t.data._id}_select_class", cl)

  'click span.s_liga': (e, t) ->
    HUMAN_FORM.remove($or:[{_id: @_pid}, {_pid: @_pid}])

  'mouseenter span.select_option': (e, t) ->
    if not @class or @class isnt "glow"
      HUMAN_FORM.update({
        _s_n: "form_sel"
        , _sel_id: @_sel_id}, {$unset: {class: ""}}, {multi: true})
      HUMAN_FORM.update({
        _s_n: "form_sel"
        , _id: @_id}, {$set: {class: "glow"}})

  'mouseenter .div_select': (e, t) ->
    if Session.equals("#{t.data._id}_select_class", "show")
      Session.set("#{t.data._id}_mov", true)
    else
      cl = Session.get("#{t.data._id}_select_class")
      if cl and cl.indexOf("show") isnt -1
        Session.set("#{t.data._id}_mov", true)

  'mouseleave .div_select': (e, t) ->
    Session.set("#{t.data._id}_mov", false)

  'focus .input_select': (e, t) ->
    a = ->
      e.currentTarget.select()
    Meteor.setTimeout(a, 20)
    cl = Session.get("#{t.data._id}_select_class")
    unless cl
      cl = "show"
      Session.set("#{t.data._id}_select_class", cl)
    else if cl and cl.indexOf("show") is -1
      cl = cl + " show"
      Session.set("#{t.data._id}_select_class", cl)

  'blur input.input_select': (e, t) ->
    if Session.equals("#{t.data._id}_mov", false)
      cl = Session.get("#{t.data._id}_select_class")
      if cl is "show"
        Session.set("#{t.data._id}_select_class", false)
      else if cl and cl.indexOf("show") isnt -1
        cl = cl.replace("show", "")
        Session.set("#{t.data._id}_select_class", cl)

Template._schema_buttons.events

  'click ._get': (e, t) ->
    console.log $(e.currentTarget)
    if @on_click
      if DATA.find(_s_n: "_tri", _tri_gr: @on_click).count() > 1
        id = HUMAN_FORM.insert(_tri_gr: @on_click, _s_n: "form_gr")
        DATA.find(_s_n: "_tri", _tri_gr: @on_click).forEach (doc) ->
          human_form_insert(doc, id)
      else
        if HUMAN_FORM.find(_s_n: "form_gr", _tri_gr: @on_click).count() is 0
          id = HUMAN_FORM.insert(_tri_gr: @on_click, _s_n: "form_gr")
          DATA.find(_s_n: "_tri", _tri_gr: @on_click).forEach (doc) ->
            human_form_insert(doc, id)
        else
          id = HUMAN_FORM.findOne(_s_n: "form_gr", _tri_gr: @on_click)
          HUMAN_FORM.remove($or:[{_id: id._id}, {_pid: id._id}])
