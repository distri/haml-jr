Util
====

    module.exports =
      CSON:
        parse: (source) ->
          Function("return #{CoffeeScript.compile(source, bare: true)}")()

      applyStylesheet: (style, id="primary") ->
        styleNode = document.createElement("style")
        styleNode.innerHTML = style
        styleNode.id = id

        if previousStyleNode = document.head.querySelector("style##{id}")
          previousStyleNode.parentNode.removeChild(prevousStyleNode)

        document.head.appendChild(styleNode)
