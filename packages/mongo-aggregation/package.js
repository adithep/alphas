Package.describe({
  summary: "REPLACEME - What does this package (or the original one you're wrapping) do?"
});

Npm.depends({mongodb: "1.4.5"});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'underscore'], ['server']);
  api.add_files('mongo-aggregation.coffee', ['client', 'server']);
});

Package.on_test(function (api) {
  api.use('mongo-aggregation');

  api.add_files('mongo-aggregation_tests.js', ['client', 'server']);
});
