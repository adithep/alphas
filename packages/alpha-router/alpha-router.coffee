Template.layout.helpers
  t_yield: ->
    LDATA.find({_mid: "current_session"}, {sort: {sort: 1}})

  t_data: ->
    if @_did
      if DATA.find(_id: @_did).count() >= 1
        return DATA.find({_id: @_did})
    return null

  t_tem: ->
    if @_tri_ty
      console.log @
      switch @_tri_ty
        when 'insert_form'
          return Template.insert_form
        when '_btn_list'
          return Template.button_list
        when 'input'
          return Template._each_input
    return null

t_build = (path, parent) ->
  par = parent or "current_session"
  pa = "_tri_grs.#{path}"
  obj = {}
  obj[pa] = {$exists: true}
  obj._s_n = "_tri"
  LDATA.remove(_mid: par)
  DATA.find(obj).forEach (doc) ->
    ld = {}
    ld._did = doc._id
    if doc._tri_grs[path].sort
      ld.sort = doc._tri_grs[path].sort
    ld._mid = par
    id = LDATA.insert(ld)
    if doc.key_ty and doc.key_ty is "r_st"
      t_build_s(doc.key_s, id)

t_build_s = (_s_n, parent) ->
  if _s_n
    par = parent or "current_session"
    obj = {}
    obj._s_n = _s_n
    LDATA.remove(_mid: par)
    DATA.find(obj).forEach (doc) ->
      ld = {}
      ld._did = doc._id
      ld._mid = par
      console.log ld
      id = LDATA.insert(ld)
      if doc.key_ty and doc.key_ty is "r_st"
        t_build_s(doc.key_s, id)

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
