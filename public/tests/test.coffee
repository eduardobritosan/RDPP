chai = require 'chai'
assert = chai.assert
routes = require "../routes/index.coffee"
main = require("./maintestfile.coffee")

describe "routes", ->
  req = {}
  res = {}
  describe "index", ->
    test "Probamos la renderización del index", ->
      res.render = (view, vars) ->
          expect(view).equal "index"
          expect(vars.title).equal "RDPP"
      routes.index(req, res)

suite 'Probando el analizador: ', ->
  test 'Probamos que detecta identificadores', ->
    original.value = 'elMejorVino = Fidencio'
    main()
    assert.match OUTPUT.innerHTML, /ID/
    return
  test 'Probamos que detecta números', ->
    original.value = 'num = 14'
    main()
    assert.match OUTPUT.innerHTML, /NUM/
    return
  test 'Declaramos x = 5', ->
    original = 'x = 5.'
    assert.equal '[{"type":"=","left":{"type":"ID","value":"x"},"right":{"type":"NUM","value":5}}]', JSON.stringify(parse(original))
    return
  test 'Operamos mezclando multiplicacion/division con suma/resta', ->
    original = 'a = 2+3-4*5/7.'
    window.main()
    assert.equal OUTPUT.innerHTML, '[\n  {\n    "type": "=",\n    "left": {\n      "type": "ID",\n      "value": "a"\n    },\n    "right": {\n      "type": "-",\n      "left": {\n        "type": "+",\n        "left": {\n          "type": "NUM",\n          "value": 2\n        },\n        "right": {\n          "type": "NUM",\n          "value": 3\n        }\n      },\n      "right": {\n        "type": "/",\n        "left": {\n          "type": "*",\n          "left": {\n            "type": "NUM",\n            "value": 4\n          },\n          "right": {\n            "type": "NUM",\n            "value": 5\n          }\n        },\n        "right": {\n          "type": "NUM",\n          "value": 7\n        }\n      }\n    }\n  }\n]'
    return
  test 'Probamos sentencia if básica', ->
    original = 'if a > 2 then b = 3.'
    window.main()
    assert.equal OUTPUT.innerHTML, '[\n  {\n    "type": "IF",\n    "left": {\n      "type": "&gt;",\n      "left": {\n        "type": "ID",\n        "value": "a"\n      },\n      "right": {\n        "type": "NUM",\n        "value": 2\n      }\n    },\n    "right": {\n      "type": "=",\n      "left": {\n        "type": "ID",\n        "value": "b"\n      },\n      "right": {\n        "type": "NUM",\n        "value": 3\n      }\n    }\n  }\n]'
    return
  test 'Probamos que puede haber un error', ->
    original.value = 'adios = 1 - (4; hola = 99'
    main()
    assert.equal OUTPUT.innerHTML, '<div class="error">Syntax Error. Expected ) found \';\' near \'; hola = 99\'</div>'
    return
  return
