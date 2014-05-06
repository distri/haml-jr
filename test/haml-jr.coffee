{parser, compile} = HamlJr = require "/haml-jr"
Runtime = require "/runtime"

global.Observable = require "observable"

makeTemplate = (code) ->
  compiled = compile code
  Function("Runtime", "return " + compiled)(Runtime)

run = (code, data) ->
  makeTemplate(code)(data)

describe 'HamlJr', ->
  describe 'parser', ->
    it 'should exist', ->
      assert(parser)

    it 'should parse some stuff', ->
      assert parser.parse("%yolo")

  describe 'compiler', ->
    describe 'keywords', ->
      it "should not replace `items.each` with `items.__each`", ->
        compiled = compile('- items.each ->')

        assert !compiled.match(/items.__each/)

      it "should replace `on 'click'` with `__runtime.on 'click'`", ->
        compiled = compile('- on "click", ->')

        assert compiled.match(/__runtime.on\("click"/)

  describe "runtime", ->
    it "should not blow up on undefined text node values", ->
      assert run('= @notThere')

  describe "classes", ->
    it "should render the classes passed in along with the classes prefixed", ->
      result = run ".radical(class=@myClass)",
        myClass: "duder"

      assert.equal result.childNodes[0].className, "radical duder"

    # TODO: Observable class attributes

  describe "ids", ->
    it "should get them from the prefix", ->
      result = run "#radical"

      assert.equal result.childNodes[0].id, "radical"

    it "should be overridden by the attribute value if present", ->
      result = run "#radical(id=@id)",
        id: "wat"

      assert.equal result.childNodes[0].id, "wat"

    it "should not be overridden by the attribute value if not present", ->
      result = run "#radical(id=@id)"

      assert.equal result.childNodes[0].id, "radical"

    # TODO: Observable id attributes

  describe "text", ->
    it "should render text in nodes", ->
      result = run "%div heyy"

      assert.equal result.childNodes[0].textContent, "heyy\n"

  describe "each", ->
    it "should subrender", ->
      global.testTemplate = makeTemplate ".test= @"
      code = """
        %div
          - each @, (item) ->
            = testTemplate item
      """
      result = run code, [0, 1, 2, 3]

      assert.equal result.childNodes[0].childNodes[3].textContent, "3"
