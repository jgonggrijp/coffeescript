# Shorthand notation for Flow comment annotations
# -------

assertCoffee2JS = (input, output) ->
  eq CoffeeScript.compile(input, bare: yes), output

# First, let's check that our modifications don't break anything.

test 'objects are still objects', ->
  input = '''
    myObj =
      a: 1
      b: 2
  '''
  output = '''
    var myObj;

    myObj = {
      a: 1,
      b: 2
    };

  '''
  assertCoffee2JS input, output

test 'inline objects are still objects', ->
  input = 'myObj = a: 1, b: 2'
  output = '''
    var myObj;

    myObj = {
      a: 1,
      b: 2
    };

  '''
  assertCoffee2JS input, output

test 'argument objects are still objects', ->
  input = 'myFunc(0, a: 1, b: 2)'
  output = '''
    myFunc(0, {
      a: 1,
      b: 2
    });

  '''
  assertCoffee2JS input, output

test 'default values are still objects', ->
  input = 'myFunc = (x, y = a: 1) -> y[x]'
  output = '''
    var myFunc;

    myFunc = function(x, y = {
        a: 1
      }) {
      return y[x];
    };

  '''
  assertCoffee2JS input, output
