Package.describe({
  summary: "Add Seed Json Files as Asset"
});

Package.on_use(function (api, where) {
  api.add_files('schema.json', ['server'], {isAsset: true});
});

Package.on_test(function (api) {
  api.use('seed-json');

  api.add_files('seed-json_tests.js', ['client', 'server']);
});
