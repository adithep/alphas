Package.describe({
  summary: "Provides form functionality"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'iron-router', 'core-lib', 'utilities', 'jade', 'stylus', 'standard-app-packages']);
  api.add_files(['form.coffee', 'form.jade', 'form.stylus'], 'client');
});

Package.on_test(function (api) {
  api.use('form');

  api.add_files('form_tests.js', ['client', 'server']);
});
