Accounts.validateNewUser ->
  true
fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')
MongoDB = Npm.require("mongodb")
BSON = MongoDB.BSONPure




Meteor.startup ->
