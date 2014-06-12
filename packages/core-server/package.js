Package.describe({
  summary: "Server Functionality"
});
Npm.depends({mongodb: "1.4.5"});
Package.on_use(function (api, where) {
  api.use(['coffeescript', 'seed-json', 'core-lib', 'accounts-base', 'accounts-password', 'mongo-aggregation']);
  api.add_files(['core-server.coffee', 'subscription.coffee'], 'server');
});

Package.on_test(function (api) {
  api.use('core-server');
  api.add_files('core-server_tests.js', ['client', 'server']);
});
