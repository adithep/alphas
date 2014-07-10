t_build = (path, parent, mid) ->
  par = parent or "current_session"
  pa = "_tri_grs.#{path}"
  obj = {}
  obj[pa] = {$exists: true}
  obj._s_n = "_tri"
  LDATA.remove(_mid: par)
  gid = new Meteor.Collection.ObjectID()
  gid = gid._str
  DATA.find(obj).forEach (doc) ->
    ld = {}
    ld._did = doc._id
    if doc._tri_grs[path].sort?
      ld.sort = doc._tri_grs[path].sort
    if doc._tri_grs[path].local_form_gr?
      ld._cid = doc._tri_grs[path].local_form_gr
    ld._mid = par
    ld._gid = gid
    console.log ld
    id = LDATA.insert(ld)
    if doc.key_ty and doc.key_ty is "r_st"
      t_build_s(doc.key_s, id, gid, doc.key_key)
    if doc.on_select
      switch doc.on_select
        when "write_form_btn"
          res = Session.get("#{gid}_v")
          if res
            oj = {}
            oj[doc.key_key] = res
            oj._s_n = doc.key_s
            sel = DATA.findOne(oj)
            if sel and sel[doc._tri_select_key]
              t_build(
                sel[doc._tri_select_key]
                id
              )
t_build_s = (_s_n, parent, gid, key) ->
  if _s_n
    par = parent or "current_session"
    obj = {}
    obj._s_n = _s_n
    LDATA.remove(_mid: par)
    one = true
    DATA.find(obj).forEach (doc) ->
      ld = {}
      ld._did = doc._id
      ld._mid = par
      id = LDATA.insert(ld)
      if one is true and key
        Session.set("#{gid}_v", doc[key])
        one = false
      if doc.key_ty and doc.key_ty is "r_st"
        t_build_s(doc.key_s, id, par, doc.key_key)

Deps.autorun ->
  if Session.equals("subscription", true)
    a = window.location.pathname
    b = a.split('/')
    t_build(b[1])

UI.body.events
  'click a[href^="/"]': (e, t) ->
    e.preventDefault()
    a = e.currentTarget.pathname
    b = a.split('/')
    t_build(b[1])
    window.history.pushState("","", a)
    return
