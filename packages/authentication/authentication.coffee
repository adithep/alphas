Template.authentication.helpers
  creatingAccount: ->
    Session.get("creatingAccount")
Template.new_account_form.events
  'click #loginform': (e, t) ->
    Session.set('creatingAccount', false)
  'click #createaccount': (e, t) ->
    Session.set('creatingAccount', false)
    Accounts.createUser
      username: t.find('#username').value
      password: t.find('#password').value
      email: t.find('#email').value
      profile:
        name: t.find('#name').value

Template.login_form.events
  'click #accountform': (e, t) ->
    Session.set('creatingAccount', true)
  'click #login': (e, t) ->
    Meteor.loginWithPassword(t.find('#username').value, t.find('#password').value)

UI.body.events
  'click #logout': (e, t) ->
    Meteor.logout()