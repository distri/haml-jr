Interactive Runtime for Docs
============================

    HamlJr = require "./haml-jr"
    global.Observable = require "observable"
    global.Runtime = require "./runtime"

    Interactive.register "demo", ({source, runtimeElement}) ->
      code =
        "var template, model;" + 
        CoffeeScript.compile(source, bare: true)

      code += "\nreturn [template, model];"

      [template, model] = Function("Observable", code)(Observable)

      view = eval(HamlJr.compile(template))

      runtimeElement.empty().append view(model)
