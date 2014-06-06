fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')

json_control.country_currency = (json, type, array, name, arry, conv, cont) ->
  ejson = EJSON.parse(Assets.getText(json))
  n = 0
  k = 0
  arr = []
  while n < ejson.length
    nn = 0
    while nn < ejson[n][array].length
      arr[k] = {}
      arr[k][type] = true
      arr[k][name] = ejson[n][name]
      if conv and cont
        obj = {}
        obj[conv] = ejson[n][array][nn]
        console.log obj
        ob = _.findWhere(ejson, obj)
        if ob[cont]
          arr[k][arry] = ob[cont]
      else
        arr[k][arry] = ejson[n][array][nn]
      nn++
      k++
    n++
  h = '../../../../../../json/' + type + '.json'
  fs.writeFileSync(
    h
    , EJSON.stringify(arr, {indent: true})
  )
  console.log arr
  return
