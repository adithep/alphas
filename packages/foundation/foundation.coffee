UI.body.events
  'mouseover .has-dropdown': (e, t) ->
    $(e.currentTarget).find(".dropdown").show()
  'mouseleave .has-dropdown': (e, t) ->
    $(e.currentTarget).find(".dropdown").hide()
  'mouseover .dropdown': (e, t) ->
    $(e.currentTarget).show()
  'mouseleave .dropdown': (e, t) ->
    $(e.currentTarget).hide()