Package.describe({
  summary: "Provides basic authentication"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'core-lib', 'utilities', 'jade', 'stylus', 'standard-app-packages']);
  api.add_files(['authentication.jade', 'authentication.coffee', 'authentication.sty'], 'client');
});

Package.on_test(function (api) {
  api.use('authentication');

  api.add_files('authentication_tests.js', ['client', 'server']);
});
