Package.describe({
  summary: "Layout"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'iron-router', 'core-lib', 'utilities', 'jade', 'stylus', 'standard-app-packages']);
  api.add_files(['layout.coffee', 'layout.jade', 'layout.sty'], 'client');
});

Package.on_test(function (api) {
  api.use('layout');

  api.add_files('layout_tests.js', ['client', 'server']);
});
