Accounts.validateNewUser ->
  true
fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')




Meteor.startup ->

  if DATA.find(_sid: "doc_schema").count() is 0
    DATA.remove({})

  if DATA.find().count() is 0
    json_control.insert_schema_keys('schema', 'schema_keys')
  else
    schema_obj.find_keys()