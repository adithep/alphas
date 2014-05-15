Package.describe({
  summary: 'Expressive, dynamic, robust CSS'
});

Package._transitional_registerBuildPlugin({
  name: "compileStylus",
  use: [],
  sources: [
    'plugin/compile-stylus.js'
  ],
  npmDependencies: { stylus: "0.44.0", nib: "1.0.2", jeet: "5.2.8", "axis-css": "0.1.8", rupture: "0.1.0", alpmixins: "0.0.9" }
});

Package.on_test(function (api) {
  api.use(['tinytest', 'alpha-stylus', 'test-helpers', 'templating']);
  api.add_files([
    'stylus_tests.html',
    'stylus_tests.styl',
    'stylus_tests.import.styl',
    'stylus_tests.js'
  ],'client');
});
