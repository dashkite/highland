import { Grid } from "@dashkite/fairfax"
import { wasserstein, fill } from "@dashkite/metro"

distill = ( options, P, Q ) ->
  { background, partial } = options
  [ m, n ] = Q.size
  P = P.resize [ m, n ], -1
  P = P.data
  Q = Q.data
  _P = ( Grid.zeros m, n ).data
  _Q = ( Grid.zeros m, n ).data
  for i in [ 0...m ]
    for j in [ 0...n ]
      vP = P[ i ][ j ]
      vQ = Q[ i ][ j ]
      _vQ = if vQ == background then 0 else 1
      _vP = if _vQ == 1
        if vP == vQ
          1
        else if vP != background
          partial
        else
          0
      else
        if vP == vQ
          0
        else
          1
      _P[ i ][ j ] = _vP
      _Q[ i ][ j ] = _vQ
  [( Grid.make _P ), ( Grid.make _Q )]

fitness = ( options, answer, question ) ->
  answer ?= Grid.from fill question.size, options.background
  [ answer, question ] = distill options, answer, question
  wasserstein answer.data, question.data

export { fitness }