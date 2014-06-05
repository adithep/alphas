fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')

json_control.country_currency = ->
  countries = EJSON.parse(Assets.getText('countries.json'))
  currencies = EJSON.parse(Assets.getText('currencies.json'))
  n = 0
  k = 0
  arr = []
  while n < countries.length
    nn = 0
    while nn < countries[n].currency.length
      arr[k] = {}
      arr[k].country_currency = true
      arr[k].country_name = countries[n].country_name
      arr[k].currency_code = countries[n].currency[nn]
      nn++
      k++
    n++
  fs.writeFileSync('../../../../../../json/c_c.json', arr)
  console.log arr

Meteor.startup ->
  json_control.print('countries.json', 'country_borders', 'borders', 'country_name', 'border', 'cca3', 'country_name')
