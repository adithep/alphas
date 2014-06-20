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
    DATA.find({_s_n: doc.key_s}, {limit: 5}).forEach (doc) ->
      doc._s_n = "form_sel"
      doc._sel_id = did
      delete doc._id
      HUMAN_FORM.insert(doc)
  return

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
    a = DATA.findOne(_s_n: this.key_s)
    parent = UI._parentData(3)
    if a?
      return a[this.key_key]
    else
      return

Template._string_select_options.helpers
  h_opt: ->
    parent = UI._parentData(1)
    return this[parent.key_key]

Template._string_input.helpers
  input_type: ->
    switch this.key_ty
      when "_dt"
        return "date"
      when "email"
        return "email"
      else
        return "text"

Template._each_input_master.helpers
  tri_gate: ->
    HUMAN_FORM.find(_pid: this._id, _s_n: "form_el")



Template._each_input.helpers
  class: ->
    str = ""
    if this.class_n?
      str = "#{str} #{this.class_n}"
    if this.key_ty is "r_st"
      str = "#{str} input_select"
    if str?
      return str
  select_options: ->
    HUMAN_FORM.find(_s_n: "form_sel", _sel_id: this._id)

Template._schema_buttons.helpers
  get_key_dis: ->
    DATA.find(_s_n: "keys", key_n: this._tri_dis)

Template.alpha_form.helpers

  schema_buttons: ->
    DATA.find({_s_n: "_tri", _tri_gr: "_get_human_buttons"}, {sort: {sort: 1}})

  input_element: ->
    HUMAN_FORM.find(_s_n: "form_gr")

Template._each_input.events
  'click span.s_liga': (e, t) ->
    HUMAN_FORM.remove($or:[{_id: this._pid}, {_pid: this._pid}])


Template._each_input.events
  'focus .input_select': (e, t) ->
    t.$('.div_select').addClass('show')
  'blur .input_select': (e, t) ->
    t.$('.div_select').removeClass('show')
  'keyup .input_select': (e, t) ->
    text = e.currentTarget.value
    if text?
      obj = {}
      obj._s_n = this.key_s
      obj[this.key_key] = { $regex: text, $options: 'i' }
      arr1 = DATA.find(obj, {limit: 5}).fetch()
      if arr1.length < 5
        len = 5 - arr1.length
        first_c = text.substr(0,1)
        obj[this.key_key] = { $regex: first_c, $options: 'i' }
        ids = _.pluck(arr1, "_id")
        obj._id = {$nin: ids}
        arr2 = DATA.find(obj, {limit: len}).fetch()
        arr1 = arr1.concat(arr2)
        if arr1.length < 5
          len = 5 - arr1.length
          ids = _.pluck(arr1, "_id")
          obj._id = {$nin: ids}
          delete obj[this.key_key]
          arr3 = DATA.find(obj, {limit: len}).fetch()
          arr1 = arr1.concat(arr3)
      HUMAN_FORM.remove(_s_n: "form_sel", _sel_id: this._id)
      if arr1? and arr1.length > 0
        n = 0
        while n < arr1.length
          arr1[n]._s_n = "form_sel"
          arr1[n]._sel_id = this._id
          delete arr1[n]._id
          HUMAN_FORM.insert(arr1[n])
          n++

Template._schema_buttons.events
  'click ._get': (e, t) ->
    if this.on_click
      if DATA.find(_s_n: "_tri", _tri_gr: this.on_click).count() > 1
        id = HUMAN_FORM.insert(_tri_gr: this.on_click, _s_n: "form_gr")
        DATA.find(_s_n: "_tri", _tri_gr: this.on_click).forEach (doc) ->
          human_form_insert(doc, id)
      else
        if HUMAN_FORM.find(_s_n: "form_gr", _tri_gr: this.on_click).count() is 0
          id = HUMAN_FORM.insert(_tri_gr: this.on_click, _s_n: "form_gr")
          DATA.find(_s_n: "_tri", _tri_gr: this.on_click).forEach (doc) ->
            human_form_insert(doc, id)
        else
          id = HUMAN_FORM.findOne(_s_n: "form_gr", _tri_gr: this.on_click)
          HUMAN_FORM.remove($or:[{_id: id._id}, {_pid: id._id}])
