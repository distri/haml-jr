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
>       %hr
>       %input(type="range" value=@value min="1" max=@max)
>       %hr
>       %progress(value=@value max=@max)
>     """
>     model =
>       max: 100
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

Select Input
------------

>     #! demo
>     template = """
>       %input(value=@selected)
>       %select(value=@selected)
>         - each @options, (option) ->
>           %option(value=option)= option
>     """
>
>     model =
>       selected: Observable 0
>       options: [0..9]

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

Interactive Runtime
-------------------

>     #! setup
>     require "/interactive"
