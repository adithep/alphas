Package.describe({
  summary: "Layout"
});

Package.on_use(function (api, where, asset) {
  api.use([
    'coffeescript'
    , 'core-lib'
    , 'utilities'
    , 'jade'
    , 'authentication'
    , 'jquery'
    , 'alpha-stylus'
    , 'standard-app-packages']);
  api.add_files([
    'liga/websymbolsligaregular.eot'
    , 'liga/websymbolsligaregular.svg'
    , 'liga/websymbolsligaregular.ttf'
    , 'liga/websymbolsligaregular.woff'], 'client', {isAsset: true});
  api.add_files([
    'layout.jade'
    , 'layout.coffee'
    , 'layout.styl'], 'client');
});

Package.on_test(function (api) {
  api.use('layout');

  api.add_files('layout_tests.js', ['client', 'server']);
});
