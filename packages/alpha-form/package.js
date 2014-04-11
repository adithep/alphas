Package.describe({
  summary: "REPLACEME - What does this package (or the original one you're wrapping) do?"
});

Package.on_use(function (api, where) {
  api.add_files(['alpha-form.jade', 'alpha-form.coffee', 'alpha-form.sty'], 'client');
});

Package.on_test(function (api) {
  api.use('alpha-form');

  api.add_files('alpha-form_tests.js', ['client', 'server']);
});
