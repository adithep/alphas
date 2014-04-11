Package.describe({
  summary: "Basic template control"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'core-lib', 'utilities', 'jade', 'stylus', 'standard-app-packages']);
  api.add_files(['template-control.coffee', 'template-control.jade', 'template-control.sty'], 'client');
});

Package.on_test(function (api) {
  api.use('template-control');

  api.add_files('template-control_tests.js', ['client', 'server']);
});
