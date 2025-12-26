import { compile } from "@dashkite/peek"
import { Forward } from "@dashkite/olympic"
import { Theory } from "./theory"
import { pick } from "@dashkite/melrose"

class Forward extends Theory

  # override
  apply: ( state ) ->
    ( compile @program )( state )

  # override
  fitness: ( result ) ->

  # override
  children: ( growth, population ) ->
    @engine ?= Forward.make @rules
    # TODO get weight from neural net
    tokens = pick growth, 
      rand @engine.chain @program
    for token in tokens
      child = @clone()
      child.program += " #{ token }"
      child



