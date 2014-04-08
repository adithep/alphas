Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'sorry_man'
  loadingTemplate: 'loading'


Router.map ->
  this.route 'module_test', {path: 'module_test'}