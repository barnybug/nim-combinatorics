proc nPk*(n, k: int32): int32 =
  ## Calculate the value of nPk.
  result = 1
  var
    k = n - k
    n = n
  while n > k:
    result *= n
    dec n
 
proc nCk*(n, k: int32): int32 =
  ## Calculate the value of nCk.
  result = nPk(n, k)
  var k = k
  while k > 0:
    result = result div k
    dec k

iterator combinations*(m: int, n: int): seq[int] =
  ## Iterates n size combinations from the first 0..<m natural numbers.
  # Adapted from: http://rosettacode.org/wiki/Combinations#Nim
  var c = newSeq[int](n)
  for i in 0..<n:
    c[i] = i
 
  block outer:
    if n == 0:
      break outer

    while true:
      yield c
 
      var i = n-1
      inc c[i]
      if c[i] <= m - 1: continue
 
      while c[i] >= m - n + i:
        dec i
        if i < 0: break outer
      inc c[i]
      while i < n-1:
        c[i+1] = c[i] + 1
        inc i

iterator combinations*[T](ys: openarray[T], n: int): seq[T] =
  ## Iterates n size combinations from the elements of ys.
  let m = len(ys)
  var rs = newSeq[T](n)

  for c in combinations(m, n):
    for i in 0..<n:
      rs[i] = ys[c[i]]
    yield rs

proc combinations*(m: int, n: int): seq[seq[int]] =
  ## Return list of the n size combinations from the first 0..<m natural numbers.
  result = @[]
  for r in combinations(m, n):
    result.add(r)

proc combinations*[T](ys: openarray[T], n: int): seq[seq[T]] =
  ## Return list of the n size combinations from the elements of ys.
  result = @[]
  for r in combinations(ys, n):
    result.add(r)

iterator permutations*[T](ys: openarray[T]): seq[T] =
  ## Iterates permutations from the elements of ys.
  # Iterative Boothroyd method taken from:
  # Taken from: http://rosettacode.org/wiki/Permutations#Nim
  var
    d = 0
    c = newSeq[int](max(2, ys.len+1))
    xs = newSeq[T](ys.len)
 
  for i, y in ys: xs[i] = y
  for i, _ in c: c[i] = i

  while true:
    yield xs
    
    d = 1
    while c[d] == 0:
      c[d] = d
      inc d
    if d >= ys.len: break

    dec c[d]
    let i = if (d and 1) == 1: c[d] else: 0
    swap xs[i], xs[d]

iterator combinationsWithReplacement*[T](ys: openarray[T], k: int): seq[T] =
  ## Iterates k combinations with replacement from the elements of ys.
  var
    c = newSeq[int](k)
    xs = newSeq[T](k)
    n = len(ys)

  for i in 0..<k:
    xs[i] = ys[c[i]]

  block outer:
    while true:
      yield xs
      # search backwards for non-maximum index
      for i in countdown(k-1,-1):
        if i == -1:
          # if all c hits maximum - done
          break outer

        if c[i] < n - 1:
          var level = c[i] + 1
          for i in i..<k:
            c[i] = level
            xs[i] = ys[level]
          break

proc combinationsWithReplacement*[T](ys: openarray[T], k: int): seq[seq[T]] =
  ## Return list of the k combinations with replacement from the elements of ys.
  result = @[]
  for r in combinationsWithReplacement(ys, k):
    result.add(r)
 
proc permutations*[T](ys: openarray[T]): seq[seq[T]] =
  ## Return list of the n size combinations from the elements of ys.
  result = @[]
  for r in permutations(ys):
    result.add(r)

iterator permutationsWithReplacement*[T](ys: openarray[T], k: int): seq[T] =
  ## Iterates k permutations with replacement from the elements of ys.
  var
    d = 1
    c = newSeq[int](k)
    xs = newSeq[T](k)
    n = len(ys)

  for i in 0..<k: xs[i] = ys[0]

  block outer:
    while true:
      yield xs

      for i in 0..k:
        if i == k:
          break outer
        elif c[i] >= n-1:
          c[i] = 0
          xs[i] = ys[0]
        else:
          c[i] += 1
          xs[i] = ys[c[i]]
          break

proc permutationsWithReplacement*[T](ys: openarray[T], k: int): seq[seq[T]] =
  ## Return list of the k permutations with replacement from the elements of ys.
  result = @[]
  for r in permutationsWithReplacement(ys, k):
    result.add(r)
