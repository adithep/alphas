HUMAN_FORM = new Meteor.Collection(null)
CITIES = new Meteor.Collection(null)

_each_dis = undefined

get_input_ty = (key_ty) ->
  if key_ty?
    switch key_ty
      when "_dt"
        return "date"
      when "email"
        return "email"
      else
        return "text"
  else
    return

human_form_insert = (doc, id) ->
  key = DATA.findOne(key_n: doc._tri_dis, _s_n: "keys")
  doc._pid = id
  for k of key
    doc[k] = key[k]
  delete doc._id
  doc._s_n = "form_el"
  doc.input_ty = get_input_ty(doc.key_ty)
  did = HUMAN_FORM.insert(doc)
  if doc.key_ty is "r_st"
    n = 0
    DATA.find({_s_n: doc.key_s}, {limit: 5}).forEach (doc) ->
      human_form_insert_select(doc, did, n++)
  return

human_form_insert_select = (doc, id, sort) ->
  doc._s_n = "form_sel"
  doc._sel_id = id
  if sort
    doc._sort = sort
  delete doc._id
  HUMAN_FORM.insert(doc)

Deps.autorun ->
  if Session.equals("subscription", true)
    h = DATA.find(
      _s_n: "_tri"
      , form_collection: "HUMAN_INPUT"
      , _tri_starting: true
    ).forEach (doc) ->
      id = HUMAN_FORM.insert(_tri_gr: doc._tri_gr, _s_n: "form_gr")
      human_form_insert(doc, id)


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
    HUMAN_FORM.find(_s_n: "form_sel", _sel_id: @_id)
  select_value: ->
    if @_v
      return @_v
    else if not @_v?
      a = HUMAN_FORM.findOne(_s_n: "form_sel", _sel_id: @_id)
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

Template._each_input.events
  'click .select_option': (e, t) ->
    HUMAN_FORM.update({_id: @_sel_id}, {$set: {_v: @[t.data.key_key]}})
    t.$('.div_select').removeClass('show')
  'click span.s_liga': (e, t) ->
    HUMAN_FORM.remove($or:[{_id: @_pid}, {_pid: @_pid}])
  'mouseenter span.select_option': (e, t) ->
    t.$(e.currentTarget).addClass("glow")
  'mouseleave span.select_option': (e, t) ->
    t.$(e.currentTarget).removeClass("glow")
  'mouseenter .div_select': (e, t) ->
    if t.$('.div_select').hasClass('show')
      t.$('.div_select').addClass('kash')
  'mouseleave .div_select': (e, t) ->
    t.$('.div_select').removeClass('kash')
  'focus .input_select': (e, t) ->
    t.$('.div_select').addClass('show')

  'blur .input_select': (e, t) ->
    if not t.$('.div_select').hasClass('kash')
      t.$('.div_select').removeClass('show')
      obj = {}
      obj._s_n = @key_s
      obj[@key_key] = @_v
      if DATA.find(obj).count() is 0
        a = HUMAN_FORM.findOne(_s_n: "form_sel", _sel_id: @_id)
        if a
          HUMAN_FORM.update({_id: @_id}, {$set: {_v: a[@key_key]}})
        else
          HUMAN_FORM.update({_id: @_id}, {$set: {_v: ""}})

  'keyup input.input_select': (e, t) ->
    if e.which is 38
      if HUMAN_FORM.find(_s_n: "form_sel", _sel_id: @_id, class: "glow").count() is 0
        a = HUMAN_FORM.update({_s_n: "form_sel", _sel_id: @_id}, {$set: {class: "glow"}})
        console.log HUMAN_FORM.find(_s_n: "form_sel", _sel_id: @_id, class: "glow").count()
      else
        a = HUMAN_FORM.update({_s_n: "form_sel", _sel_id: @_id, class: "glow"}, {$unset: {class: ""}})
        console.log a

    if e.which is 40
      console.log "hello"

    text = e.currentTarget.value
    if text?
      obj = {}
      obj._s_n = @key_s
      ids = []
      idn = 0
      n = 0
      obj[@key_key] = { $regex: text, $options: 'i' }
      HUMAN_FORM.remove(_s_n: "form_sel", _sel_id: @_id)

      len = 5 - ids.length
      DATA.find(obj, {limit: len}).forEach (doc) =>
        ids[idn++] = doc._id
        human_form_insert_select(doc, @_id, n++)

      if ids.length < 5
        cur = DATA.find(_s_n: @key_s)
        word = utilities.most_similar_string(cur, @key_key, text, -1, false)
        if word
          if ids.indexOf(word._id) is -1
            ids[idn++] = word._id
            word._s_n = "form_sel"
            word._sel_id = @_id
            word.sort = n++
            delete word._id
            HUMAN_FORM.insert(word)
        if ids.length < 5
          len = 5 - ids.length
          str_l = text.length
          first_c = "^#{text.substr(0,1)}"
          obj[@key_key] = { $regex: first_c, $options: 'i' }
          obj._id = {$nin: ids}
          DATA.find(obj, {limit: len}).forEach (doc) =>
            ids[idn++] = doc._id
            human_form_insert_select(doc, @_id, n++)
          if ids.length < 5
            len = 5 - ids.length
            obj._id = {$nin: ids}
            delete obj[@key_key]
            DATA.find(obj, {limit: len}).forEach (doc) =>
              ids[idn++] = doc._id
              human_form_insert_select(doc, @_id, n++)
      HUMAN_FORM.update({_id: @_id}, {$set: {_v: e.currentTarget.value}})

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
