Package.describe({
  summary: "Add Seed Json Files as Asset and it's control functions."
});

Package.on_use(function (api, where, asset) {
  api.use(['coffeescript', 'core-lib'])
  api.add_files(['schema_keys.json', 'schema.json'], ['server'], {isAsset: true});
  api.add_files('json_control.coffee', 'server');
  api.export('json_control', 'server');
});

Package.on_test(function (api) {
  api.use('seed-json');

  api.add_files('seed-json_tests.js', ['client', 'server']);
});
