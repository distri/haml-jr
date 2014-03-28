Interactive Runtime for Docs
============================

    HamlJr = require "./haml-jr"
    Observable = require "observable"

    Interactive.register "demo", ({source, runtimeElement}) ->
      code = CoffeeScript.compile(source, bare: true)

      code += "\nreturn [template, model];"

      [template, model] = Function("Observable", code)(Observable)

      view = HamlJr.compile(template)
      
      runtimeElement.empty().append view(model)
