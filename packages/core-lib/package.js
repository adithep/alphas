Package.describe({
  summary: "Provides Collection Name, Schema, and Schema Keys"
});

Package.on_use(function (api, where) {
  api.add_files(['namespace.js'], ['client', 'server']);
  api.add_files('namespace_client.js', 'client');
  api.export([
    'get_sid',
    'get_kid',
    'get_tid',
    'fill_sid',
    'json_control',
    'DATA',
    'ODATA',
    'LDATA',
    'phone_format',
    'email_format',
    'subscription',
    'utilities'
  ]);
});

Package.on_test(function (api) {
  api.use('core-lib');

  api.add_files('core-lib_tests.js', ['client', 'server']);
});
