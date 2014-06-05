Package.describe({
  summary: "Utilities for controling JSON, XML and CSV"
});

Package.on_use(function (api, where) {
  api.use([
    'coffeescript'
    , 'core-lib'
    , 'seed-json'
  ]);
  api.add_files('json-control.coffee', 'server');
});

Package.on_test(function (api) {
  api.use('json-control');

  api.add_files('json-control_tests.js', ['client', 'server']);
});
