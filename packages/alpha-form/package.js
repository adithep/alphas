Package.describe({
  summary: "Provides form functionality"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'jade', 'stylus', 'standard-app-packages', 'core-lib', 'underscore'])
  api.add_files(['alpha-form.jade', 'alpha-form.coffee', 'alpha-form.styl'], 'client');
});

Package.on_test(function (api) {
  api.use('alpha-form');

  api.add_files('alpha-form_tests.js', ['client', 'server']);
});
