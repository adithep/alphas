t_build = (path, parent, mid) ->
  if path
    par = parent or "top"
    pa = "_tri_grs.#{path}"
    obj = {}
    obj[pa] = {$exists: true}
    obj._s_n = "_tri"
    if DATA.find(obj).count() >= 1
      group = LDATA.insert(_gpa: path, _mid: par)
      DATA.find(obj).forEach (doc) ->
        ld = {}
        ld._did = doc._id
        if doc._tri_grs[path].sort?
          ld.sort = doc._tri_grs[path].sort
        ld._gid = group
        console.log doc
        id = LDATA.insert(ld)
        if doc.key_ty and doc.key_ty is "r_st"
          dgr = LDATA.findOne(_gpa: "sel_opt", _mid: id)
          if dgr
            unless Session.equals("#{id}_sel_opt", dgr._id)
              Session.set("#{id}_sel_opt", dgr._id)
          else
            sel_gr = t_build_s(doc.key_s, id, "sel_opt", doc.key_key)
            Session.set("#{id}_sel_opt", sel_gr)
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
                    on_sel_gr = LDATA.findOne(
                      _gpa: sel[doc._tri_select_key]
                      _mid: group
                    )
                    if on_sel_gr
                      unless Session.equals("#{group}_form_btn", on_sel_gr._id)
                        Session.set("#{group}_form_btn", on_sel_gr._id)
                    else
                      gr = t_build(
                        sel[doc._tri_select_key]
                        group
                      )
                      Session.set("#{group}_form_btn", gr)
      return group
  return false

t_build_s = (_s_n, parent, gid, key) ->
  if _s_n and parent
    group = LDATA.insert(_gpa: gid, _mid: parent)
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
    return group
  return false

Deps.autorun ->
  if Session.equals("subscription", true)
    a = window.location.pathname
    b = a.split('/')
    dgr = LDATA.findOne(_gpa: b[1], _mid: "top")
    if dgr
      unless Session.equals("current_session", dgr._id)
        Session.set("current_session", dgr._id)
    else
      gr = t_build(b[1])
      Session.set("current_session", gr)

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
      gr = t_build(b[1])
      Session.set("current_session", gr)
    window.history.pushState("","", a)
    return
