Package.describe({
  summary: "Layout"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'core-lib', 'utilities', 'jade', 'stylus', 'standard-app-packages', 'famono']);
  api.add_files(['layout.jade', 'layout.coffee', 'layout.sty'], 'client');
  api.export('FM');
});

Package.on_test(function (api) {
  api.use('layout');

  api.add_files('layout_tests.js', ['client', 'server']);
});
