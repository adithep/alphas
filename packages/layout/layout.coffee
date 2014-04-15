require("famous-polyfills")
require("famous/core/famous")

Meteor.startup ->
  Engine = require 'famous/core/Engine'
  View = require 'famous/core/View'
  Surface = require 'famous/core/Surface'
  Lightbox = require 'famous/core/Lightbox'

  context = Engine.createContext()
  context.add(Surface)
