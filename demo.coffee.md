Hamlet Demo
===========

Hamlet is a templating language for web applications. It's like React, Angular,
or Knockout except not awful.

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
>       %select(value=@value options=[1..@max])
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
>         model.items.push model.name()
>         model.name("")
>         return false


---

Knockout Demo
-------------

>     #! demo
>     template = """
>       %select(value=@chosenTicket options=@tickets)
>       %button(disabled=@disabled click=@reset) Clear
>       .choice
>         - each @chosenTicket, ->
>           .ticket
>             - if @price
>               You have chosen!
>               %b= @name
>               = @price
>     """
>     tickets = [
>       {name: "Choose...", price: ""}
>       {name: "Economy", price: 199.95}
>       {name: "Business", price: 449.22}
>       {name: "First Class", price: 1199.99}
>     ]
>     model =
>       newTicket: ->
>         tickets.push name: "Yolo", price: "Free!"
>       tickets: tickets
>       chosenTicket: Observable(tickets[0])
>       reset: -> model.chosenTicket(tickets[0])
>     model.disabled = Observable -> model.chosenTicket() is tickets[0]

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
>     last = Observable("Doberman")
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
