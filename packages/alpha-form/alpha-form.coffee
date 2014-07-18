@HUMAN_FORM = new Meteor.Collection(null)

@get_parent_data = (t, num) ->
  n = num or 1
  k = 0
  one = t
  while k < n
    one = one.__component__.parent.templateInstance
    one = one.__component__.parent.templateInstance
    one = one.__component__.parent.templateInstance
    k++
  return one.__component__.parent._super.data()

@get_input_ty = (key_ty) ->
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

@human_form_insert = (on_click, parent, sela) ->
  obj = {}
  pa = "_tri_grs.#{on_click}"
  obj[pa] = {$exists: true}
  obj._s_n = "_tri"
  gr = LDATA.insert(
    _gr: on_click
    _sid: sela
    depth: parent.depth
    _pid: parent._pid
    _s_n: "_gr"
  )
  DATA.find(obj).forEach (doc) ->
    ld = {}
    ld._did = doc._id
    ld.depth = parent.depth
    if doc._tri_grs[on_click].sort?
      ld.sort = doc._tri_grs[on_click].sort
    ld._gid = gr
    ld._sid = sela
    ld._pid = parent._pid
    ld._s_n = "doc"
    console.log doc
    console.log ld
    id = LDATA.insert(ld)
    if doc._tri_ty is "input" and doc.key_ty and doc.key_ty is "r_st"
      dgr = LDATA.findOne(_gr: "_sel_opt", _sid: id)
      unless dgr
        cdr = space_bud_d(
          doc.key_s
          doc.key_key
          "_sel_opt"
          id
          parent.depth
          sela
          parent._pid
        )
        Session.set("#{id}_sel_opt", cdr)
      else
        unless Session.equals("#{id}_sel_opt", dgr._id)
          Session.set("#{id}_sel_opt", dgr._id)

@human_form_insert_select = (s_n, id, ids) ->
  if s_n? and typeof s_n is 'object'
    obj = s_n
  else
    obj = {_s_n: s_n}
  if ids and Array.isArray(ids) and ids.length > 0
    k = ids.length
    lim = 5 - ids.length
  else
    k = 0
    lim = 5
    ids = []
  DATA.find(obj, {limit: lim}).forEach (doc) ->
    ids = human_form_insert_select_one(doc, id, ids, k)
    k++
  return ids

@human_form_insert_select_one = (doc, id, ids, k) ->
  doc._s_n = "form_sel"
  doc._sel_id = id
  doc.sort = k
  doc._vid = doc._id
  ids[k] = doc._id
  delete doc._id
  HUMAN_FORM.insert(doc)
  return ids

Deps.autorun ->
  if Session.equals("subscription", true)
    h = DATA.find(
      _s_n: "_tri"
      , form_collection: "HUMAN_INPUT"
      , _tri_starting: true
    ).forEach (doc) ->
      id = HUMAN_FORM.insert(_tri_gr: doc._tri_gr, _s_n: "form_gr")
      human_form_insert(doc, id)
