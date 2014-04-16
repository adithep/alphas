

Application = null;

Meteor.startup(function () {
    var Engine = require("famous/core/Engine");
    var View = require("famous/core/View");

    var Surface = require("famous/core/Surface");
    var Modifier = require("famous/core/Modifier");
    var InputSurface = require("famous-surfaces/InputSurface");
    var ContainerSurface = require("famous-surfaces/ContainerSurface");
    var Navigation = require("famous-widgets/TabBar");
    var Lightbox = require("famous/views/Lightbox");
    var Transitionable = require('famous/transitions/Transitionable');

    var context = Engine.createContext();
    var inputsurface = new InputSurface({placeholder: 'hello'});
    var surface = new Surface();
    var modifier = new Modifier();
    var modifier2 = new Modifier();
    var state = new Transitionable([700, 80]);
    var navigation = new Navigation();
    var lightbox = new Lightbox();

    var container = new ContainerSurface({size: [200, 30]});
    
    
    context.add(inputsurface);

});