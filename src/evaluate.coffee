

# theory = @theory
# theory.prepare()
# @cache[ theory.key] ?= yield from do ->
#   try
#     state = yield from theory.train()   
#   catch error
#     if error instanceof InvalidTheory
#       theory.viable = false
#       return Result.make {
#         theory
#         score: Number.MAX_SAFE_INTEGER
#       }
#     else
#       throw error

#   total = 0
#   for result from state.results
#     total += fitness { result.data..., partial: 0.75 }, 
#       result.proposal,
#       result.answer

#   Result.make { 
#     theory
#     state
#     # weight these by dimension?
#     # or put them into one big grid?
#     score: total
#   }