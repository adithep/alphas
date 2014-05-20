Accounts.validateNewUser ->
  true
fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')




Meteor.startup ->

  if DATA.find(_sid: "doc_schema").count() is 0
    DATA.remove({})

  if DATA.find().count() is 0
    json_control.insert_schema_keys('keys', 'schema', 'schema_keys', 'tags')
  else
    fill_sid.init()

  if DATA.find(_sid: get_sid.currencies).count() is 0
    json_control.insert_json('currencies', get_sid.currencies)

  if DATA.find(_sid: get_sid.countries).count() is 0
    json_control.insert_json('countries', get_sid.countries)

  if DATA.find(_sid: get_sid.services).count() is 0
    json_control.insert_json('services', get_sid.services)

  if DATA.find(_sid: get_sid.titles).count() is 0
    json_control.insert_json('titles', get_sid.titles)

  if DATA.find(_sid: get_sid.cities).count() is 0
    json_control.insert_json('cities', get_sid.cities)
    DATA.find(_sid: get_sid.countries, _kid: get_kid.capital).forEach (doc) ->
      city = DATA.findOne
        _sid: get_sid.cities
        , _kid: get_kid.doc_name
        , _v: doc._v
      if city
        DATA.update({_id: doc._id}, $set: {_v: city._did})
        console.log "#{city._v} updated"
      else
        console.log "cannot find city #{doc._v}"
