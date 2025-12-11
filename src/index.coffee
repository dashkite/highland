import { metaclass } from "@dashkite/joy/metaclass"
import { parse } from "./parse"
import { format } from "./format"

class Theory extends metaclass()

  @make: ( task, program = []) ->
    self = Object.assign ( new @ ), { task, program }

  @getters

    key: -> @toString()

  toString: ->
    "Theory(#{ format @program })"

  clone: ->
    @constructor.make @task, format @program

  apply: ( state ) ->
    for operation in @operations
      state = operation.apply state
      yield state
    state

  # override
  fitness: ->

  train: ->
    @apply task.state "train"

  test: ->
    @apply task.state "test"

  evaluate: ->
    @fitness yield from @train()

  children: ( growth, population ) ->


export { Theory }