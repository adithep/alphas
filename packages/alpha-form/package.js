Package.describe({
  summary: "Provides form functionality"
});

Package.on_use(function (api, where) {
  api.use([
    'coffeescript',
    'alpha-stylus',
    'standard-app-packages',
    'core-lib',
    'underscore',
    'jquery',
    'layout']);
  api.add_files([
    'alpha-form.html',
    'alpha-form.coffee',
    'form-helpers.coffee',
    'form-events.coffee',
    'alpha-form.styl'], 'client');
});

Package.on_test(function (api) {
  api.use('alpha-form');

  api.add_files('alpha-form_tests.js', ['client', 'server']);
});
