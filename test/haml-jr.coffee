{parser, compile} = HamlJr = require "/haml-jr"

run = (compiled, data) ->
  Function("Runtime", "return " + compiled)(require "/runtime")(data)

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
      compiled = compile('= @notThere')
      assert run(compiled)

  describe "classes", ->
    it "should render the classes passed in along with the classes prefixed", ->
      compiled = compile(".radical(class=@myClass)")

      result = run compiled,
        myClass: "duder"

      assert.equal result.childNodes[0].className, "radical duder"

    # TODO: Observable class attributes

  describe "ids", ->
    it "should get them from the prefix", ->
      compiled = compile("#radical")
      result = run compiled

      assert.equal result.childNodes[0].id, "radical"

    it "should be overridden by the attribute value if present", ->
      compiled = compile("#radical(id=@id)")
      result = run compiled,
        id: "wat"

      assert.equal result.childNodes[0].id, "wat"

    it "should not be overridden by the attribute value if not present", ->
      compiled = compile("#radical(id=@id)")
      result = run compiled

      assert.equal result.childNodes[0].id, "radical"

    # TODO: Observable id attributes

  describe "text", ->
    it "should render text in nodes", ->
      compiled = compile("%div heyy")
      result = run compiled

      assert.equal result.childNodes[0].textContent, "heyy\n"
