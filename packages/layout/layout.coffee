
context = null

Template.site.rendered = ->

  Engine = require("famous/core/Engine")
  View = require("famous/core/View")
  Surface = require("famous/core/Surface")
  Modifier = require("famous/core/Modifier")
  InputSurface = require("famous/surfaces/InputSurface")
  ContainerSurface = require("famous/surfaces/ContainerSurface")
  Navigation = require("famous/widgets/TabBar")
  Lightbox = require("famous/views/Lightbox")
  Transitionable = require("famous/transitions/Transitionable")
  SModifier = require("famous/modifiers/StateModifier")
  Transform = require("famous/core/Transform")
  RenderNode = require("famous/core/RenderNode")
  SpringTransition = require("famous/transitions/SpringTransition")

  navigation = new Navigation()
  start = new Transitionable(50, 50, 0)
  end = new Transitionable(200, 300, 0)
  translate_mod = new SModifier
    transform: Transform.translate(150, 100, 0)
  rotate_mod = new SModifier
    transform: Transform.rotateZ(Math.PI/4)
  origin_mod = new Modifier
  ani_mod = new SModifier
  surface = new Surface
    content: Template.input
    classes: ["testsurface"]
    properties:
      color: 'white',
      textAlign: 'center',
      backgroundColor: '#FA5C4F'
  view = new View
    size: [true, 200]
  node = new RenderNode
  Transitionable.registerMethod('spring', SpringTransition);
  context = Engine.createContext()
  origin_mod2 = new SModifier
    origin: [0, 0]
  
  surface.on 'click', (e) ->
    origin_mod1 = new SModifier
      origin: [0, 0]
    surface1 = new Surface
      size: [100, 100]
      content: "<span>hello world</span>"
      classes: ["testsurface"]
      properties:
        color: 'white',
        textAlign: 'center',
        backgroundColor: '#FA5C4F'
    view.add(origin_mod1).add(surface1)
  
  surfacet = new Surface
    size: [true, 100]
    properties:
      backgroundColor: "green"
  surfacet2 = new Surface
    size: [true, 100]
    properties:
      backgroundColor: "yellow"
  spring =
    method: 'spring'
    period: 1000
    dampingRatio: 0.3
  ani_mod.setTransform Transform.translate(100, 300, 0), spring
  div = document.createElement('div')
  mySurface = new Surface
    size: [100, 100]
    content: div
    properties:
      backgroundColor: "#fa5c4f"
      lineHeight: "100px"
      textAlign: "center"
      color: "#eee"
  UI.insert(UI.render(Template.input), div)
  myModifier = new SModifier
  context.add(surfacet)
  view.add(node)
  node.add(origin_mod).add(mySurface)
  context.add(view)
  mySurface.setSize([50, 100])
  

  Engine.on "click", ->
    myModifier.halt()
    myModifier.setTransform Transform.rotateZ(Math.random() * Math.PI / 2),
      curve: "easeOut"
      duration: 5000

    return


    
  
