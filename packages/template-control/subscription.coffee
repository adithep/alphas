Deps.autorun ->
  if Meteor.user()
    subscription.sub_list = Meteor.subscribe "list"
    if subscription.sub_list.ready()
      Session.set("subscription", true)
  else
    if subscription.sub_list
      subscription.sub_list.stop()
    if subscription.sub_humans
      subscription.sub_humans.stop()
    Session.set("subscription", false)
  return
