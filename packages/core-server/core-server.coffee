Accounts.validateNewUser ->
  true
fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')
MongoDB = Npm.require("mongodb")
BSON = MongoDB.BSONPure




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
      bs = {}
      bs.city = new BSON.ObjectID(get_sid.cities._str)
      bs.doc_name = new BSON.ObjectID(get_kid.doc_name._str)
      bs.country = new BSON.ObjectID(get_kid.country._str)
      bs._v = new BSON.ObjectID(doc._did._str)
      pipeline = [
        {$match: {
          _sid: bs.city
          , _kid: {$in: [bs.doc_name, bs.country]}
          , _v: {$in: [bs._v, doc._v]}
        }}
        , {$group: {
          _id: "$_did"
          , count: {$sum: 1}
        }}
        , {$match: {
          count: {$gt: 1}
        }

        }
      ]
      result = DATA.aggregate pipeline
      if result
        oid = new Meteor.Collection.ObjectID(result[0]._id.toString())
        if oid
          DATA.update({_id: doc._id}, $set: {_v: oid})
          console.log "#{doc._v} updated: #{oid._str}"
        else
          console.log "cannot find city #{doc._v}"
      else
        "no result"
