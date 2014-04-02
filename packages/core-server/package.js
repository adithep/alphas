Package.describe({
  summary: "Server Functionality"
});

Package.on_use(function (api, where) {
	api.use('coffeescript', 'seed-json');
  api.add_files('data-lib.coffee', ['client', 'server']);
  api.add_files('core-server.coffee', ['server']);
});

Package.on_test(function (api) {
  api.use('core-server');
  api.add_files('core-server_tests.js', ['client', 'server']);
});
