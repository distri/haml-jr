Runtime
=======

This runtime component is all you need to render compiled HamlJr templates.

    if window?
      document = window.document
    else
      document = global.document

    eventNames = """
      abort
      error
      resize
      scroll
      select
      submit
      change
      reset
      focus
      blur
      click
      dblclick
      keydown
      keypress
      keyup
      load
      unload
      mousedown
      mousemove
      mouseout
      mouseover
      mouseup
      drag
      dragend
      dragenter
      dragleave
      dragover
      dragstart
      drop
    """.split("\n")

    isEvent = (name) ->
      eventNames.indexOf(name) != -1

    Runtime = (context) ->
      stack = []

      # HAX: A document fragment is not your real dad
      lastParent = ->
        i = stack.length - 1
        while (element = stack[i]) and element.nodeType is 11
          i -= 1

        element

      top = ->
        stack[stack.length-1]

      append = (child) ->
        top()?.appendChild(child)

        return child

      push = (child) ->
        stack.push(child)

      pop = ->
        append(stack.pop())

      render = (child) ->
        push(child)
        pop()

      bindObservable = (element, value, update) ->
        # CLI short-circuits here because it doesn't do observables
        unless Observable?
          update(value)
          return

        observable = Observable(value)

        observe = ->
          observable.observe update
          update observable()

        unobserve = ->
          observable.stopObserving update

        element.addEventListener("DOMNodeInserted", observe, true)
        element.addEventListener("DOMNodeRemoved", unobserve, true)

        return element

      id = (sources...) ->
        element = top()

        update = (newValue) ->
          # HACK: Working around CLI not having observables
          if typeof newValue is "function"
            newValue = newValue()

          element.id = newValue

        value = ->
          possibleValues = sources.map (source) ->
            if typeof source is "function"
              source()
            else
              source
          .filter (idValue) ->
            idValue?

          possibleValues[possibleValues.length-1]

        bindObservable(element, value, update)

      classes = (sources...) ->
        element = top()

        update = (newValue) ->
          # HACK: Working around CLI not having observables
          if typeof newValue is "function"
            newValue = newValue()

          element.className = newValue

        value = ->
          possibleValues = sources.map (source) ->
            if typeof source is "function"
              source()
            else
              source
          .filter (sourceValue) ->
            sourceValue?

          possibleValues.join(" ")

        bindObservable(element, value, update)

      observeAttribute = (name, value) ->
        element = top()

        if (name is "value") and (typeof value is "function")
          element.value = value()

          element.onchange = ->
            value(element.value)

          if value.observe
            value.observe (newValue) ->
              element.value = newValue
        # Straight up onclicks, etc.
        else if name.match /^on/
          element[name] = value
        # Handle click=@method
        else if isEvent(name)
          element["on#{name}"] = value
        else
          update = (newValue) ->
            element.setAttribute name, newValue

          bindObservable(element, value, update)

        return element

      observeText = (value) ->
        # Kind of a hack for handling sub renders
        # or adding explicit html nodes to the output
        # TODO: May want to make more sure that it's a real dom node
        #       and not some other object with a nodeType property
        # TODO: This shouldn't be inside of the observeText method
        switch value?.nodeType
          when 1, 3, 11
            render(value)
            return

        # HACK: We don't really want to know about the document inside here.
        # Creating our text nodes in here cleans up the external call
        # so it may be worth it.
        element = document.createTextNode('')

        update = (newValue) ->
          element.nodeValue = newValue

        bindObservable element, value, update

        render element

      self =
        # Pushing and popping creates the node tree
        push: push
        pop: pop

        id: id
        classes: classes
        attribute: observeAttribute
        text: observeText

        filter: (name, content) ->
          ; # TODO self.filters[name](content)

        each: (items, fn) ->
          items = Observable(items)
          elements = []
          parent = lastParent()

          # TODO: Work when rendering many sibling elements
          items.observe (newItems) ->
            replace elements, newItems

          replace = (oldElements, items) ->
            if oldElements
              # TODO: There a lot of trouble if we can't find a parent
              # We may be able to hack around it by observing when
              # we're inserted into the dom and finding out what parent element
              # we have
              firstElement = oldElements[0]
              parent = firstElement?.parentElement || parent

              elements = items.map (item, index, array) ->
                element = fn.call(item, item, index, array)

                parent.insertBefore element, firstElement

                return element

              oldElements.forEach (element) ->
                element.remove()
            else
              elements = items.map (item, index, array) ->
                element = fn.call(item, item, index, array)

                return element

          replace(null, items)


      return self

    module.exports = Runtime
