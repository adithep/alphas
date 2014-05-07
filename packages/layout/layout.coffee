
Template.menu.events
  'mouseenter li': (e, tpl) ->
    $(e.currentTarget).find('div').addClass('show')
  'mouseleave li': (e, tpl) ->
    $(e.currentTarget).find('div').removeClass('show')

Template.layout.events
  'mouseenter .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().addClass('show')
  'mouseleave .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().removeClass('show')
  'click .logout': (e, tpl) ->
    Meteor.logout()
