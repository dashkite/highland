  # findings: ( growth ) ->
  #   result = []
  #   # for failed theories the state may be 
  #   if @theory.viable
  #     result.push ( @_grow growth )...
  #     result.push ( @_mutate growth )...
  #   ( shuffle result )[...growth]

  # _grow: ( n ) ->
  #   available = ( shuffle @theory.available )[...n]
  #   for operator in available when operator.viable @state
  #     theory = @theory.clone()
  #     theory.add operator
  #     theory

  # _mutate: ( n ) ->
  #   entries = @theory.mutable.entries() 
  #   mutable = shuffle Array.from entries
  #   for [ i ] in mutable[ ...n ]
  #     theory = @theory.clone()
  #     theory.mutable[ i ].mutate()
  #     theory
