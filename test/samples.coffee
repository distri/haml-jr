{parser, compile} = HamlJr = require "/haml-jr"

samples =
  attributes: """
    .yolo(id=@id class="cool cat" data-test="test" dude=@test)
    #test.yolo2(class=@duder)
  """
  browser: """
    %html
      %head
        %script(src="lib/cornerstone.js")
        %script(src="lib/coffee-script.js")
        %script(src="lib/jquery-1.10.2.min.js")
        %script(src="build/web.js")
      %body
        %textarea
          :verbatim
            Choose a ticket class:
            %select
              - on "change", @chosenTicket
              - each @tickets, ->
                %option= @name
    
            %button Clear
              - on "click", @resetTicket
    
            - with @chosenTicket, ->
              %p
                - if @price
                  You have chosen
                  %b= @name
                  %span
                    $#{@price}
                - else
                  No ticket chosen
    
  """
  code_following_text: """
    Some Text
    - a = "wat"
  """
  complex: """
    %select
      - radicalMessage = "Yolo"
      - @tickets.forEach (ticket, i) ->
        - if i is 0
          = radicalMessage
        %option
          = ticket.name
  """
  complex2: """
    !!!
    %html
      %head
        %title Ravel | #{@name}'s photo tagged #{@tag}
    
        - @props.each (key, value) ->
          %meta(property=key content=value)
    
        %link{:href => "/images/favicon.ico", :rel => "icon", :type => "image/x-icon"}
    
        %link(rel="stylesheet" href="/stylesheets/normalize.css")
        %link(rel="stylesheet" href="/stylesheets/bootstrap.min.css")
        %link(rel="stylesheet" href="/stylesheets/main.css")
    
        %script{:src => "//use.typekit.net/ghp4eka.js"}
        :javascript
          try{Typekit.load();}catch(e){}
    
      %body
        .facebook
          %header
            %h1.hide-text
              Ravel
          .content
            .container
              .individual
                .user-container.clearfix
                  .left
                    .user-image
                      %img{:src => @profile_picture_url}
                    .user-info
                      %span.name= @name
                      %span.info= @gender_and_age
                      %span.location.info= @location
                      %span.tag= @tag
                  .right
                    %span.pins
                      %img{:src => "/images/pins@2x.png"}
                      = @pins
                    %span.likes
                      %img{:src => "/images/likes@2x.png"}
                      = @likes
                .photo-container
                  %img{:src => @photo_url}
              .download-button
                %a.button.appstore{:href => "http://itunes.apple.com/us/app/ravel!/id610859881?ls=1&mt=8"}
  """
  empty_lines: """
    %li
      
      %ul
        
        Yo
      
    
        
    
        
  """
  filters: """
    :plain
      cool
      super cool
        double super cool
  """
  filters2: """


    :javascript
      alert('yolo');
    
    :coffeescript
      alert "yolo"
    
    .duder
      col
    
      :plain
        sweets
    
    .duder2
      cool

  """
  literal: """
    <literal>
      <wat>
      </wat>
    </literal>
    <yolo></yolo>
  """
  simple: """
    %section#main.container
      - post = title: "cool", subtitle: "yolo", content: "radical"
      %h1= post.title
      %h2= post.subtitle
      .content
        = post.content
  """
  single_quotes: """
    %img(src='http://duderman.info/\#{yolocountyusa}' data-rad='what the duder?')
  """
  tickets: """
    Choose a ticket class:
    %select
      - on "change", @chosenTicket
      - each @tickets, ->
        %option= @name
    
    %button Clear
      - on "click", @resetTicket
    
    - with @chosenTicket, ->
      %p
        - if @price
          You have chosen
          %b= @name
          %span
            $#{@price}
        - else
          No ticket chosen
  """

describe "Samples", ->
  Object.keys(samples).forEach (name) ->
    data = samples[name]

    it "should parse '#{name}'", ->
      result = parser.parse(data)
      console.log result
      assert result

    it "should compile #{name}", ->
      assert compile(data)
