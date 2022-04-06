import combinatorics
import unittest
import intsets
from math import fac

test "permutations([])":
  let xs: seq[char] = @[]
  check permutations(xs) == @[xs]

test "permutations(['a'])":
  check permutations(['a']) == @[@['a']]

test "permutations(['a', 'b'])":
  check permutations(['a', 'b']) == @[@['a', 'b'], @['b', 'a']]

test "permutations(['a', 'b', 'c'])":
  check permutations(['a', 'b', 'c']) == @[@['a', 'b', 'c'], @['b', 'a', 'c'], @['c', 'a', 'b'], @['a', 'c', 'b'], @['b', 'c', 'a'], @['c', 'b', 'a']]

test "permutations(['a', 'b', 'c']) iterator":
  var result = newSeq[seq[char]](0)
  for c in permutations(['a', 'b', 'c']):
    result.add(c)
  check result == @[@['a', 'b', 'c'], @['b', 'a', 'c'], @['c', 'a', 'b'], @['a', 'c', 'b'], @['b', 'c', 'a'], @['c', 'b', 'a']]

test "permutations(*) iterator":
  for l in 0..9:
    var xs = newSeq[int](l)
    for i in 0..<l: xs[i] = i
    var s = initIntSet()
    for cs in permutations(xs):
      # each permutation must be of length l
      check len(cs) == l
      # each permutation must contain digits from 0 to l-1 once
      var ds = newSeq[bool](l)
      for c in cs:
        check not ds[c]
        ds[c] = true
      # generate a unique number for each permutation
      var h = 0
      for e in cs:
        h = l * h + e
      check not s.contains(h)
      s.incl(h) 
    # check exactly l! unique number of permutations
    assert len(s) == fac(l)

test "permutationsWithReplacement(['a', 'b', 'c'], 2)":
  var result = permutationsWithReplacement(['a', 'b', 'c'], 2)
  var expected = @[@['a', 'a'], @['b', 'a'], @['c', 'a'], @['a', 'b'], @['b', 'b'], @['c', 'b'], @['a', 'c'], @['b', 'c'], @['c', 'c']]
  check expected == result

test "permutationsWithReplacement(['a', 'b', 'c'], 2) iterator":
  var result = newSeq[seq[char]](0)
  for c in permutationsWithReplacement(['a', 'b', 'c'], 2):
    result.add(c)
  var expected = @[@['a', 'a'], @['b', 'a'], @['c', 'a'], @['a', 'b'], @['b', 'b'], @['c', 'b'], @['a', 'c'], @['b', 'c'], @['c', 'c']]
  check expected == result
