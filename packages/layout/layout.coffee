Template.layout.events
  'mouseenter .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().addClass('show')
  'mouseleave .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().removeClass('show')
  'click .logout': (e, tpl) ->
    Meteor.logout()
