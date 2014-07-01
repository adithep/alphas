UI.registerHelper 't_yield', ->
  a = Session.get("current_path")
  if not a
    b = window.location.pathname
    c = b.split("/")
    Session.set("current_path", c[1])
  if DATA.find(_tri_gr: a, _s_n: "_tri").count() > 1
    return DATA.find(_tri_gr: a)

  return Template.sorry_man

UI.registerHelper 't_data', ->
  if @_tri_ty
    switch @_tri_ty
      when 'insert_form'
        return Template.insert_form
      when 'button_list'
        return Template.button_list
  return Template.sorry_man

UI.body.events
  'click a[href^="/"]': (e, t) ->
    e.preventDefault()
    a = e.currentTarget.pathname
    b = a.split('/')
    Session.set("current_path", b[1])
    window.history.pushState("","", a)
    return
