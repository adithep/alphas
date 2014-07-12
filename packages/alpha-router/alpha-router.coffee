t_build = (path, parent, mid) ->
  if path
    par = parent or "top"
    pa = "_tri_grs.#{path}"
    obj = {}
    obj[pa] = {$exists: true}
    obj._s_n = "_tri"
    if DATA.find(obj).count() >= 1
      group = LDATA.insert(_gpa: path, _mid: par)
      Session.set("current_session", group._id)
      DATA.find(obj).forEach (doc) ->
        ld = {}
        ld._did = doc._id
        if doc._tri_grs[path].sort?
          ld.sort = doc._tri_grs[path].sort
        ld._gid = group
        console.log ld
        if LDATA.find(ld).count() is 0
          id = LDATA.insert(ld)

          if doc.key_ty and doc.key_ty is "r_st"
            dgr = LDATA.findOne(_gpa: "sel_opt", _mid: id)
            if dgr
              unless Session.equals("#{id}_sel_opt", dgr._id)
                Session.set("#{id}_sel_opt", dgr._id)
            else
              t_build_s(doc.key_s, id, "sel_opt", doc.key_key)
          ###
          if doc.on_select
            switch doc.on_select
              when "write_form_btn"
                res = Session.get("#{id}_v")
                if res
                  oj = {}
                  oj[doc.key_key] = res
                  oj._s_n = doc.key_s
                  sel = DATA.findOne(oj)
                  if sel and sel[doc._tri_select_key]
                    t_build(
                      sel[doc._tri_select_key]
                      id
                      par
                    )
                  if not Session.equals("#{par}_form_sel", sel[doc._tri_select_key])
                    Session.set("#{par}_form_sel", sel[doc._tri_select_key])
              ###
    else
      Session.set("current_session", false)
  else
    Session.set("current_session", false)

t_build_s = (_s_n, parent, gid, key) ->
  if _s_n and parent
    group = LDATA.insert(_gpa: gid, _mid: parent)
    Session.set("#{parent}_sel_opt", group._id)
    one = true
    DATA.find(_s_n: _s_n).forEach (doc) ->
      ld = {}
      ld._did = doc._id
      ld._gid = group
      id = LDATA.insert(ld)
      if one is true and key
        unless Session.equals("#{parent}_v", doc[key])
          Session.set("#{parent}_v", doc[key])
        one = false
      if doc.key_ty and doc.key_ty is "r_st"
        t_build_s(doc.key_s, id, parent, doc.key_key)

Deps.autorun ->
  if Session.equals("subscription", true)
    a = window.location.pathname
    b = a.split('/')
    dgr = LDATA.findOne(_gpa: b[1], _mid: "top")
    if dgr
      unless Session.equals("current_session", dgr._id)
        Session.set("current_session", dgr._id)
    else
      t_build(b[1])

UI.body.events
  'click a[href^="/"]': (e, t) ->
    e.preventDefault()
    a = e.currentTarget.pathname
    b = a.split('/')
    dgr = LDATA.findOne(_gpa: b[1], _mid: "top")
    if dgr
      unless Session.equals("current_session", dgr._id)
        Session.set("current_session", dgr._id)
    else
      t_build(b[1])
    window.history.pushState("","", a)
    return
