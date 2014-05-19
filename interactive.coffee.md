Interactive Runtime for Docs
============================

    require "./lib/hamlet"

    {CoffeeScript, Observable, Compiler} = Hamlet

    # {applyStylesheet, CSON} = require "./lib/util"
    # applyStylesheet require "./style/demo"

    # TODO: Textarea for template, text area for data, live interactive demo
    # Changing data reloads the new data into the same template
    # Changing template reloads the same data into the new template

    Interactive.register "demo", ({source, runtimeElement}) ->
      code =
        "var template, model;" +
        CoffeeScript.compile(source, bare: true)

      code += "\nreturn [template, model];"

      [template, model] = Function("Observable", code)(Observable)

      view = Function("return " + Compiler.compile(template, runtime: "Hamlet"))()

      runtimeElement.empty().append view(model)
