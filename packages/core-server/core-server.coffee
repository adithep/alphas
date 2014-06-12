Accounts.validateNewUser ->
  true
fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')
MongoDB = Npm.require("mongodb")
BSON = MongoDB.BSONPure




Meteor.startup ->
  DATA.remove({})
  json_control.insert_json_detail()
