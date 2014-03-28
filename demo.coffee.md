Haml Jr Demo
============

Haml Jr is a templating language for JavaScript. It's like Backbone or Knockout,
except not awful.

Example
-------

>     #! demo
>     template = """
>       %h1 Radical
>       %hr
>       %p Hello duder.
>     """

Example
-------

>     #! demo
>     template = """
>       %input(type="text" value=@value)
>       %input(type="range" value=@value min="1" max="10")
>       = @value
>     """
>     model =
>       value: Observable 5

Interactive Runtime
-------------------

>     #! setup
>     require "/interactive"
