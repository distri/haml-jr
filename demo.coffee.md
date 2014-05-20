Hamlet Demo
===========

Hamlet is a templating language for web applications. It's like React, Angular,
or Knockout except even better!

Multiple Bindings
-----------------

>     #! demo
>     template = """
>       %input(type="text" @value)
>       %select(@value options=[1..@max])
>       %hr
>       %input(type="range" @value min="1" @max)
>       %hr
>       %progress(@value @max)
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

Dependent Functions
-------------------

>     #! demo
>     template = """
>       %h2= @name
>       %input(value=@first)
>       %input(value=@last)
>     """
>
>     model =
>       name: ->
>         "#{@first()} #{@last()}"
>       first: Observable("Mr.")
>       last: Observable("Doberman")

---

Checkbox
--------

>     #! demo
>     template = """
>       %label
>         %input(type="checkbox" @checked)
>         = @checked
>     """
>     model =
>       checked: Observable true

---

Disabling Inputs
----------------

>     #! demo
>     template = """
>       %button(click=@hello @disabled) A Button
>       %button(click=@toggle) Toggle
>     """
>     model =
>       hello: ->
>         alert "hello"
>       disabled: Observable true
>       toggle: ->
>         @disabled.toggle()
>

---

TODO List
---------

>     #! demo
>     template = """
>       %h2 TODO List
>       %ul(style="list-style-type: none; padding: 0;")
>         - each @items, (item) ->
>           %li
>             %label
>               %input(type="checkbox")
>               = item
>       %form(submit=@add)
>         %input(value=@name)
>         %button Add Item
>     """
>     model =
>       name: Observable ""
>       items: Observable []
>       add: ->
>         @items.push @name()
>         @name("")
>         return false


---

Knockout Demo
-------------

>     #! demo
>     template = """
>       %select(value=@chosenTicket options=@tickets)
>       %button(@disabled click=@reset) Clear
>       .choice
>         - each @chosenTicket, ->
>           .ticket
>             - if @price
>               You have chosen!
>               %b= @name
>               = @price
>     """

>     model =
>       tickets: [
>         {name: "Choose...", price: ""}
>         {name: "Economy", price: 199.95}
>         {name: "Business", price: 449.22}
>         {name: "First Class", price: 1199.99}
>       ]
>       chosenTicket: Observable()
>       reset: ->
>         @chosenTicket(@tickets[0])
>       disabled: ->
>         @chosenTicket() is @tickets[0] or !@chosenTicket()?

---


Interactive Runtime
-------------------

>     #! setup
>     require "/interactive"
