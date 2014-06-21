Template._each_input.events

  'click .select_option': (e, t) ->
    HUMAN_FORM.update(
      {_id: @_sel_id}
      , { $set: {_v: @[t.data.key_key]}, $unset: {select_class: ""} }
    )

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
    if t.$('.div_select').hasClass('show')
      HUMAN_FORM.update({_id: @_id}, {$set: {mov: true}})

  'mouseleave .div_select': (e, t) ->
    HUMAN_FORM.update({_id: @_id}, {$unset: {mov: ""}})

  'focus .input_select': (e, t) ->
    a = ->
      e.currentTarget.select()
    Meteor.setTimeout(a, 20)

    HUMAN_FORM.update({_id: @_id}, {$set: {select_class: "show"}})

  'blur input.input_select': (e, t) ->
    if not @mov
      HUMAN_FORM.update({_id: @_id}, {$unset: {select_class: ""}})
      sel = HUMAN_FORM.findOne
        _s_n: "form_sel"
        _sel_id: @_id
        class: "glow"
      if sel
        HUMAN_FORM.update({_id: @_id}, {$set: {_v: sel[@key_key]}})
      else
        obj = {}
        obj._s_n = @key_s
        obj[@key_key] = @_v
        if DATA.find(obj).count() is 0
          a = HUMAN_FORM.findOne(_s_n: "form_sel", _sel_id: @_id)
          if a
            HUMAN_FORM.update({_id: @_id}, {$set: {_v: a[@key_key]}})
          else
            HUMAN_FORM.update({_id: @_id}, {$set: {_v: ""}})

Template._schema_buttons.events

  'click ._get': (e, t) ->
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
