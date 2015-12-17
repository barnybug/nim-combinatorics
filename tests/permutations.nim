import combinatorics
import unittest

test "permutations(['a', 'b', 'c'])":
  check permutations(['a', 'b', 'c']) == @[@['a', 'b', 'c'], @['b', 'a', 'c'], @['c', 'a', 'b'], @['a', 'c', 'b'], @['b', 'c', 'a'], @['c', 'b', 'a']]

test "permutations(['a', 'b', 'c']) iterator":
  var result = newSeq[seq[char]](0)
  for c in permutations(['a', 'b', 'c']):
    result.add(c)
  check result == @[@['a', 'b', 'c'], @['b', 'a', 'c'], @['c', 'a', 'b'], @['a', 'c', 'b'], @['b', 'c', 'a'], @['c', 'b', 'a']]
