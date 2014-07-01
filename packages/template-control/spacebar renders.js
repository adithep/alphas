Template.__define__("_schema_buttons", (function() {
  var self = this;
  var template = this;                                                                                     // 4
  return HTML.LI({                                                                                         // 5
    $dynamic: [ function() {                                                                               // 6
      return Spacebars.attrMustache(self.lookup("attrs"));                                                 // 7
    } ]                                                                                                    // 8
  }, "\n    ", HTML.A("\n      ", UI.Each(function() {                                                     // 9
    return Spacebars.call(self.lookup("get_key_dis"));                                                     // 10
  }, UI.block(function() {                                                                                 // 11
    var self = this;                                                                                       // 12
    return [ "\n        ", Spacebars.include(self.lookupTemplate("_key_dis")), "\n      " ];               // 13
  })), "\n    "), "\n  ");                                                                                 // 14
}));                                                                                                       // 15
                                                                                                           // 16
Template.__define__("alpha_form", (function() {                                                            // 17
  var self = this;                                                                                         // 18
  var template = this;                                                                                     // 19
  return [ HTML.Raw('<a class="save_human_json right">Save Json</a>\n\n  '), HTML.NAV({                    // 20
    "class": "form_nav"                                                                                    // 21
  }, "\n    ", HTML.UL("\n      ", UI.Each(function() {                                                    // 22
    return Spacebars.call(self.lookup("schema_buttons"));                                                  // 23
  }, UI.block(function() {                                                                                 // 24
    var self = this;                                                                                       // 25
    return [ "\n        ", Spacebars.include(self.lookupTemplate("_schema_buttons")), "\n      " ];        // 26
  })), "\n    "), "\n  "), "\n\n  ", HTML.FORM({                                                           // 27
    "class": "contact_form"                                                                                // 28
  }, "\n    ", UI.Each(function() {                                                                        // 29
    return Spacebars.call(self.lookup("input_element"));                                                   // 30
  }, UI.block(function() {                                                                                 // 31
    var self = this;                                                                                       // 32
    return [ "\n      ", Spacebars.include(self.lookupTemplate("_each_input_master")), "\n    " ];         // 33
  })), HTML.Raw('\n    <br>\n    <a class="form_submit">Submit</a>\n  ')) ];                               // 34
}));                                                                                                       // 35
                                                                                                           // 36
Template.__define__("_each_input_master", (function() {                                                    // 37
  var self = this;                                                                                         // 38
  var template = this;                                                                                     // 39
  return HTML.DIV({                                                                                        // 40
    "class": "_each_input_master"                                                                          // 41
  }, "\n    ", UI.Each(function() {                                                                        // 42
    return Spacebars.call(self.lookup("tri_gate"));                                                        // 43
  }, UI.block(function() {                                                                                 // 44
    var self = this;                                                                                       // 45
    return [ "\n      ", Spacebars.include(self.lookupTemplate("_each_input")), "\n    " ];                // 46
  })), "\n  ");                                                                                            // 47
}));                                                                                                       // 48
                                                                                                           // 49
Template.__define__("_each_input", (function() {                                                           // 50
  var self = this;                                                                                         // 51
  var template = this;                                                                                     // 52
  return HTML.DIV({                                                                                        // 53
    "class": "contact_div"                                                                                 // 54
  }, "\n    ", UI.Unless(function() {                                                                      // 55
    return Spacebars.call(Spacebars.dot(self.lookup("."), "_tri_starting"));                               // 56
  }, UI.block(function() {                                                                                 // 57
    var self = this;                                                                                       // 58
    return [ "\n      ", HTML.SPAN({                                                                       // 59
      "class": "s_liga"                                                                                    // 60
    }, "Î"), "\n    " ];                                                                                   // 61
  })), "\n    ", HTML.INPUT({                                                                              // 62
    type: function() {                                                                                     // 63
      return Spacebars.mustache(Spacebars.dot(self.lookup("."), "input_ty"));                              // 64
    },                                                                                                     // 65
    placeholder: function() {                                                                              // 66
      return Spacebars.mustache(Spacebars.dot(self.lookup("."), "key_dis"));                               // 67
    },                                                                                                     // 68
    "class": [ function() {                                                                                // 69
      return Spacebars.mustache(self.lookup("class"));                                                     // 70
    }, " input_ui" ],                                                                                      // 71
    value: function() {                                                                                    // 72
      return Spacebars.mustache(self.lookup("select_value"));                                              // 73
    }                                                                                                      // 74
  }), "\n    ", HTML.DIV({                                                                                 // 75
    "class": [ "div_select ", function() {                                                                 // 76
      return Spacebars.mustache(Spacebars.dot(self.lookup("."), "select_class"));                          // 77
    } ]                                                                                                    // 78
  }, "\n      ", UI.Each(function() {                                                                      // 79
    return Spacebars.call(self.lookup("select_options"));                                                  // 80
  }, UI.block(function() {                                                                                 // 81
    var self = this;                                                                                       // 82
    return [ "\n        ", Spacebars.include(self.lookupTemplate("_string_select_options")), "\n      " ]; // 83
  })), "\n    "), "\n  ");                                                                                 // 84
}));                                                                                                       // 85
                                                                                                           // 86
Template.__define__("_key_dis", (function() {                                                              // 87
  var self = this;                                                                                         // 88
  var template = this;                                                                                     // 89
  return HTML.SPAN(function() {                                                                            // 90
    return Spacebars.mustache(Spacebars.dot(self.lookup("."), "key_dis"));                                 // 91
  });                                                                                                      // 92
}));                                                                                                       // 93
                                                                                                           // 94
Template.__define__("_string_select_options", (function() {                                                // 95
  var self = this;                                                                                         // 96
  var template = this;                                                                                     // 97
  return HTML.SPAN({                                                                                       // 98
    "class": [ "input_ui select_option ", function() {                                                     // 99
      return Spacebars.mustache(Spacebars.dot(self.lookup("."), "class"));                                 // 100
    } ]                                                                                                    // 101
  }, function() {                                                                                          // 102
    return Spacebars.mustache(self.lookup("h_opt"));                                                       // 103
  });                                                                                                      // 104
}));

UI.body.contentParts.push(UI.Component.extend({render: (function() {                  // 2
  var self = this;                                                                    // 3
  return UI.If(function() {                                                           // 4
    return Spacebars.call(Spacebars.dot(self.lookup("currentUser"), "username"));     // 5
  }, UI.block(function() {                                                            // 6
    var self = this;                                                                  // 7
    return Spacebars.include(self.lookupTemplate("layout"));                          // 8
  }), UI.block(function() {                                                           // 9
    var self = this;                                                                  // 10
    return Spacebars.include(self.lookupTemplate("authentication"));                  // 11
  }));                                                                                // 12
})}));                                                                                // 13
                                                                                      // 14
Meteor.startup(function () { if (! UI.body.INSTANTIATED) {                            // 15
  UI.body.INSTANTIATED = true; UI.materialize(UI.body, document.body);                // 16
}});                                                                                  // 17
                                                                                      // 18
Template.__define__("layout", (function() {                                           // 19
  var self = this;                                                                    // 20
  var template = this;                                                                // 21
  return [ HTML.NAV({                                                                 // 22
    "class": "nav_large"                                                              // 23
  }, HTML.Raw('<a href="/"><h1>αSΨS</h1></a>\n<ul><li><a href="/alpha_form">Insert</a></li>\n<li><a>Display</a></li></ul>\n'), HTML.UL({
    "class": "right user"                                                             // 25
  }, HTML.LI(HTML.A(function() {                                                      // 26
    return Spacebars.mustache(Spacebars.dot(self.lookup("currentUser"), "username")); // 27
  })), HTML.Raw('\n<li><a href="#" class="logout">`</a></li>'))), HTML.DIV({          // 28
    id: "content"                                                                     // 29
  }, Spacebars.include(self.lookupTemplate("alpha_yield"))) ];                        // 30
}));                                                                                  // 31
                                                                                      // 32
Template.__define__("sorry_man", (function() {                                        // 33
  var self = this;                                                                    // 34
  var template = this;                                                                // 35
  return HTML.Raw("<h1>Nothing found on this address... Ahghhhhhhh What to do, what to do?</h1><p>I am so afraid...</p>");
}));

Template.__define__("authentication", (function() {                                        // 2
  var self = this;                                                                         // 3
  var template = this;                                                                     // 4
  return HTML.DIV({                                                                        // 5
    id: "logindiv"                                                                         // 6
  }, HTML.DIV(HTML.Raw("<h1>Login</h1>\n"), UI.If(function() {                             // 7
    return Spacebars.call(Spacebars.dot(self.lookup("currentUser"), "username"));          // 8
  }, UI.block(function() {                                                                 // 9
    var self = this;                                                                       // 10
    return HTML.H1("logged in");                                                           // 11
  }), UI.block(function() {                                                                // 12
    var self = this;                                                                       // 13
    return UI.If(function() {                                                              // 14
      return Spacebars.call(self.lookup("loggingIn"));                                     // 15
    }, UI.block(function() {                                                               // 16
      var self = this;                                                                     // 17
      return HTML.P("Logging in...");                                                      // 18
    }), UI.block(function() {                                                              // 19
      var self = this;                                                                     // 20
      return UI.If(function() {                                                            // 21
        return Spacebars.call(self.lookup("creatingAccount"));                             // 22
      }, UI.block(function() {                                                             // 23
        var self = this;                                                                   // 24
        return Spacebars.include(self.lookupTemplate("new_account_form"));                 // 25
      }), UI.block(function() {                                                            // 26
        var self = this;                                                                   // 27
        return Spacebars.include(self.lookupTemplate("login_form"));                       // 28
      }));                                                                                 // 29
    }));                                                                                   // 30
  }))));                                                                                   // 31
}));                                                                                       // 32
                                                                                           // 33
Template.__define__("new_account_form", (function() {                                      // 34
  var self = this;                                                                         // 35
  var template = this;                                                                     // 36
  return HTML.Raw('<input type="text" id="email" placeholder="email"><input type="text" id="name" placeholder="name"><input type="text" id="username" placeholder="username"><input type="password" id="password" placeholder="password"><button id="createaccount">Create</button><p id="loginform">(Login)</p>');
}));                                                                                       // 38
                                                                                           // 39
Template.__define__("login_form", (function() {                                            // 40
  var self = this;                                                                         // 41
  var template = this;                                                                     // 42
  return HTML.Raw('<input type="text" id="username" placeholder="username"><input type="password" id="password" placeholder="password"><button id="login">Login</button><br><button id="accountform">Create Account</button>');
}));
