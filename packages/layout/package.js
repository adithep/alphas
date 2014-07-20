Package.describe({
  summary: "Layout"
});

Package.on_use(function (api, where, asset) {
  api.use([
    'coffeescript'
    , 'core-lib'
    , 'utilities'
    , 'authentication'
    , 'jquery'
    , 'alpha-stylus'
    , 'standard-app-packages']);
  api.add_files([
    'layout.html'
    , 'layout.coffee'
    , 'essential.styl'
    , 'layout.styl'], 'client');
});

Package.on_test(function (api) {
  api.use('layout');

  api.add_files('layout_tests.js', ['client', 'server']);
});
