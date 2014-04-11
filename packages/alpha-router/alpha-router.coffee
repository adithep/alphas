UI.registerHelper 'alpha_yield', ->
  a = Session.get("current_path")
  if not a
    b = window.location.pathname
    c = b.split("/")
    Session.set("current_path", c[1])
  if Template[a]
    Template[a]
  else
    Template.sorry_man

UI.body.events
  'click a[href^="/"]': (e, t) ->
    e.preventDefault()
    a = e.currentTarget.pathname
    b = a.split('/')
    Session.set("current_path", b[1])
    window.history.pushState("","", a)
    return