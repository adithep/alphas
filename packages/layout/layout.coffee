

Meteor.startup ->

  Engine = require 'famous/core/Engine'
  View = require 'famous/core/View'
  Surface = require 'famous/core/Surface'
  Modifier = require "famous/core/Modifier"
  Lightbox = require 'famous/views/Lightbox'
  InputSurface = require "famous-surfaces/InputSurface"
  ContainerSurface = require "famous-surfaces/ContainerSurface"
  Transitionable = require 'famous/transitions/Transitionable'
  Navigation = require "famous-widgets/TabBar"
  navigation = new Navigation()
  start = new Transitionable(50, 50, 0)
  end = new Transitionable(200, 300, 0)
  tran = new Modifier(transformFrom: start)
  surface = new Surface
    size: [100, 100]
    content: "<p>surface<p>"
    classes: ["testsurface"]
  surface.on 'click', (e) ->
    tran.transformFrom(end)
    start = [end, end = start][0]

  context = Engine.createContext()
  context.add(tran).add(surface)
  
