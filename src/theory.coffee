import { metaclass } from "@dashkite/joy/metaclass"

class Theory extends metaclass()

  @make: ({ task, operators, rules, program }) ->
    self = Object.assign ( new @ ),
      { task, operators, rules, program }

  @getters

    key: -> @program

  toString: -> @key
    
  clone: ->
    @constructor.make @

  train: ->
    @apply task.state "train"

  test: ->
    @apply task.state "test"

  evaluate: ->
    @fitness yield from @train()

  # override
  apply: ( state ) ->
      
  # override
  fitness: ( result ) ->

  # override
  children: ( growth, population ) ->

export { Theory }