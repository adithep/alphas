Package.describe({
  summary: "Add Seed Json Files as Asset and it's control functions."
});

Package.on_use(function (api, where) {
  api.use(['coffeescript', 'core-lib', 'utilities']);
  api.add_files([
    '_s/_s.json',
    '_s/keys.json',
    '_s/classes.json',
    'json/_alt_spellings.json',
    'json/borders_of_country.json',
    'json/country_language.json',
    'json/country_currency.json',
    'json/languages.json',
    'json/currencies.json',
    'json/countries.json',
    'json/cities.json',
    'json/continents.json',
    'json/service_n.json',
    'json/tags.json',
    'json/translations.json',
    'json/titles.json',
    'json/humans.json',
    'json/services.json',
    'json/_alt_mobiles.json',
    'json/_alt_emails.json',
    'json/companies.json',
    'json/input_forms.json',
    '_s_json/tri_defaults.json',
    '_s_json/master_tri.json',
    '_s_json/_get_human_btn.json',
    '_s_json/_get_human_input.json',
    '_s_json/_get_service_input.json',
    '_s_json/_get_mobile_input.json',
    '_s_json/_get_email_input.json'], 'server', {isAsset: true});
  api.add_files('json_control.coffee', 'server');
});

Package.on_test(function (api) {
  api.use('seed-json');

  api.add_files('seed-json_tests.js', ['client', 'server']);
});
