@HUMAN_FORM = new Meteor.Collection(null)

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

@human_form_insert = (doc, id) ->
  key = DATA.findOne(key_n: doc._tri_dis, _s_n: "keys")
  doc._pid = id
  for k of key
    doc[k] = key[k]
  delete doc._id
  doc._s_n = "form_el"
  doc.input_ty = get_input_ty(doc.key_ty)
  did = HUMAN_FORM.insert(doc)
  if doc.key_ty is "r_st"
    human_form_insert_select(doc.key_s, did)
  return

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
