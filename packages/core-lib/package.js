Package.describe({
  summary: "Provides Collection Name, Schema, and Schema Keys"
});

Package.on_use(function (api, where) {
  api.add_files(['namespace.js', 'schema_keys.coffee'], ['client', 'server']);
  api.export(['schema_obj', 'json_control', 'DATA'])
});

Package.on_test(function (api) {
  api.use('core-lib');

  api.add_files('core-lib_tests.js', ['client', 'server']);
});
