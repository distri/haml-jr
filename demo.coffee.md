Haml Jr Demo
============

Haml Jr is a templating language for JavaScript. It's like Backbone or Knockout,
except not awful.

Simple HTML
-------

>     #! demo
>     template = """
>       %h1 Radical
>       %hr
>       %p Hello duder.
>     """

---

Multiple Bindings
-----------------

>     #! demo
>     template = """
>       %input(type="text" value=@value)
>       %select(value=@value)
>         - each [1..@max], (option) ->
>           %option(value=option)= option
>       %hr
>       %input(type="range" value=@value min="1" max=@max)
>       %hr
>       %progress(value=@value max=@max)
>     """
>     model =
>       max: 10
>       value: Observable 5

---

Inline Events
-------------

>     #! demo
>     template = """
>       %button(click=@hello) Hello!
>     """
>     model =
>       hello: ->
>         alert "hello"

---

Disabling Inputs
----------------

>     #! demo
>     template = """
>       %button(disabled=@disabled click=@hello) A Button
>       %button(click=@toggle) Toggle
>     """
>     model =
>       hello: ->
>         alert "hello"
>       disabled: Observable true
>       toggle: ->
>         model.disabled.toggle()
>

---


Dependent Functions
-------------------

>     #! demo
>     template = """
>       %h2= @name
>       %input(value=@first)
>       %input(value=@last)
>     """
>
>     first = Observable("Mr.")
>     last = Observable("Duderman")
>
>     model =
>       name: ->
>         first() + " " + last()
>       first: first
>       last: last

---

Checkbox
--------

>     #! demo
>     template = """
>       %label
>         %input(type="checkbox" checked=@checked)
>         = @checked
>     """
>     model =
>       checked: Observable true

---


Interactive Runtime
-------------------

>     #! setup
>     require "/interactive"
