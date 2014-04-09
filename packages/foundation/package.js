Package.describe({
  summary: "Foundation for Meteor"
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'standard-app-packages', 'ui'])
  api.add_files(['foundation.min.css', 'normalize.css', 'foundation.coffee'], 'client');
});

Package.on_test(function (api) {
  api.use('foundation');

  api.add_files('foundation_tests.js', ['client', 'server']);
});
