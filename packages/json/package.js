Package.describe({
  summary: "Provide Json Files to Server"
});

Package.on_use(function (api, where) {
  api.add_files('schema.json', ['server']);
});

Package.on_test(function (api) {
  api.use('json');

  api.add_files('json_tests.js', ['client', 'server']);
});
