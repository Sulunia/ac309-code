local fenwick = {}
local tree = {}
local bit = require("bit")

local receivedInput = {}
local sum = 0

function fenwick.constructBITree(input)
  --Reseta a árvore previamente construída
  tree = {}
  tree[0] = 0
  receivedInput = fenwick._cloneTable(input)
  inputSize = #input
  print(" ================= Construct BIT")
  print("Tree[0] = 0")

  --Gera a árvore
  for k1, v1 in ipairs(input) do
    sum = 0
    for i = fenwick.parent(k1), k1-1, 1 do
      sum = sum + input[i+1]
    end
    tree[k1] = sum
    print("Tree["..k1.."] = "..tree[k1])
  end
  print("END CONSTRUCT =================")

  return tree
end

function fenwick.updateInput(index, val)
  print("================= Update element")
  --define o aumento
  step = val - receivedInput[index]

  --atualizo vetor de referência
  receivedInput[index] = receivedInput[index] + step

  --visita os nós até esgotar o vetor
  while tree[index] ~= nil do
    tree[index] = tree[index] + step
    index = index + fenwick.getRightmostBit(index)
  end

  for k=0,7 do
    print("Tree["..k.."] = "..tree[k])
  end
  print("END UPDATE =================")
end

function fenwick.getSum(index)
  print("================= Sum vector")
  print("")
  posAux = index
  --inicializa a soma
  sum = 0

  --soma de acordo com a BIT
  while(index > 0) do
    sum = sum + tree[index]
    index = index - fenwick.getRightmostBit(index)
  end
  print("Soma dos elementos ate o "..posAux..": "..sum)
  print("")
  print("END SUM =================")
end

function fenwick.getRightmostBit(value)
  --wtf
  return bit.tohex(bit.bxor(bit.bor((value-1), value), (value-1)))
end

function fenwick.parent(x)
  return bit.band(x, (x - 1))
end

function fenwick._cloneTable(table)
  newTbl = {}
  for k, v in ipairs(table) do
    newTbl[k] = v
  end
  return newTbl
end

return fenwick
