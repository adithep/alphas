Deps.autorun ->
  if Meteor.user()
    subscription.sub_sche = Meteor.subscribe "schema"
    subscription.sub_list = Meteor.subscribe "list"
    if subscription.sub_sche.ready() and subscription.sub_list.ready()
      fill_sid.init()
      Session.set("subscription", true) 
  else
    if subscription.sub_list
      subscription.sub_list.stop()
    if subscription.sub_sche
      subscription.sub_sche.stop()
    if subscription.sub_humans
      subscription.sub_humans.stop()
    Session.set("subscription", false)
    fill_sid.destroy()   
  return