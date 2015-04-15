
chai = require 'chai'
expect   = chai.expect
routes = require "../../routes/index.coffee"
main = require("./maintestfile.coffee")

describe "routes", ->
  req = {}
  res = {}
  describe "index", ->
    it "Should have an index with a predictive parser title", ->
      res.render = (view, vars) ->
          expect(view).equal "index"
          expect(vars.title).equal "RDPP"
      routes.index(req, res)

describe "parsing", ->
	it "Should parse + sentences", ->
		results = main.parse("x = 33 - 5.")
		expect(results[0].type).equal('=')
		expect(results[0].right.type).equal("-")
		expect(results[0].right.left.value).equal(33)
		expect(results[0].right.right.value).equal(5)
	it "Should parse - sentences", ->
		results = main.parse("p 2 - 4 - 5.")
		expect(results[0].type).equal("P")
		expect(results[0].value.type).equal("-")
		expect(results[0].value.left.left.value).equal(2)
		expect(results[0].value.left.type).equal("-")
		expect(results[0].value.left.right.value).equal(4)
		expect(results[0].value.right.value).equal(5)

	it "Should parse if sentences", ->
		results = main.parse("if vino == fidencio then bares = resuelta.")
		expect(results[0].type).equal("IF")
		expect(results[0].left.type).equal("==")
		expect(results[0].right.type).equal("=")
