Package.describe({
  summary: "Provides basic authentication"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'iron-router', 'core-lib', 'utilities', 'jade', 'stylus', 'standard-app-packages']);
  api.add_files(['authentication.coffee', 'authentication.jade', 'authentication.stylus'], 'client');
});

Package.on_test(function (api) {
  api.use('authentication');

  api.add_files('authentication_tests.js', ['client', 'server']);
});