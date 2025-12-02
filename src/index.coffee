import { inspect } from "node:util"
import { metaclass } from "@dashkite/joy/metaclass"
import { shuffle } from "@dashkite/joy/array"
import * as Operators from "#types/operators"

lookup = ( name ) ->
  if ( operator = Operators[ name ])?
    operator
  else
    throw new Error "unknown operation: #{ name }"

make = ( name ) ->
  ( lookup name ).make()

class Theory extends metaclass()

  @make: ( puzzle, operations = []) ->
    self = Object.assign ( new @ ), {
      puzzle
      viable: true
      operations: operations.map make
    }

  @getters

    key: -> @toString()

    available: ->
      Object.values Operators
      # self = @
      # @_available ?= do ->
      #   all = new Set Object.values Operators
      #   current =
      #     new Set self.operations.map ( operation ) ->
      #       operation.constructor
      #   Array.from new Set do ->
      #     all
      #       .difference current
      #       .values()

    canGrow: -> @available.length > 0

    mutable: ->
      self = @
      @_mutable ?= do -> 
        self
          .operations
          .filter ( operation ) ->
            operation.constructor.mutable

    canMutate: -> @mutable.length > 0
          
  has: ( name ) ->
    @operations
      .some ( operation ) ->
        operation.constructor.name == name

  add: ( k ) ->
    @operations.push k.make()
    # force recalculation
    @_available = undefined
    @_mutable = undefined
    @

  prepare: ->
    state = @puzzle.state "train"
    for operation in @operations when operation.prepare?
      operation.prepare state
    return

  apply: ( mode ) ->
    state = @puzzle.state mode
    for operation in @operations
      state = operation.apply state
      yield state
    state

  train: -> @apply "train"

  test: -> @apply "test"

  clone: ->
    theory = Theory.make @puzzle
    theory.operations = 
      @operations
        .map ( operation ) -> 
          operation.clone()
    theory

  update: ( name, mutator ) ->
    target = lookup name 
    operator = @operations.find ( operator ) -> 
      operator.constructor == target
    operator.update mutator

  toString: ->
    operations = 
      @operations
        .map ( operation ) ->
          operation.toString()
        .join "|"
    "Theory(#{ operations })"

  [inspect.custom]: -> @toString()

class InvalidTheory extends Error

export { Theory, InvalidTheory }