import combinatorics
import unittest

test "combinations(3, 0)":
  check combinations(3, 0).len == 0

test "combinations(3, 1)":
  check combinations(3, 1) == @[@[0], @[1], @[2]]

test "combinations(3, 2)":
  check combinations(3, 2) == @[@[0, 1], @[0, 2], @[1, 2]]

test "combinations(3, 3)":
  check combinations(3, 3) == @[@[0, 1, 2]]

test "combinations(3, 2) iterator":
  var result = newSeq[seq[int]](0)
  for c in combinations(3, 2):
    result.add(c)
  check result == @[@[0, 1], @[0, 2], @[1, 2]]

test "combinations(['a', 'b', 'c'], 1)":
  check combinations(@['a', 'b', 'c'], 1) == @[@['a'], @['b'], @['c']]

test "combinations(['a', 'b', 'c'], 2)":
  check combinations(@['a', 'b', 'c'], 2) == @[@['a', 'b'], @['a', 'c'], @['b', 'c']]

test "combinationsWithReplacement([3, 4, 5], 1)":
  var expected = @[@[3], @[4], @[5]]
  check combinationsWithReplacement([3, 4, 5], 1) == expected

test "combinationsWithReplacement([3, 4, 5], 2)":
  var expected = @[@[3, 3], @[3, 4], @[3, 5], @[4, 4], @[4, 5], @[5, 5]]
  check combinationsWithReplacement([3, 4, 5], 2) == expected

test "combinationsWithReplacement([3, 4, 5], 3)":
  var expected = @[@[3, 3, 3], @[3, 3, 4], @[3, 3, 5], @[3, 4, 4], @[3, 4, 5], @[3, 5, 5], @[4, 4, 4], @[4, 4, 5], @[4, 5, 5], @[5, 5, 5]]
  check combinationsWithReplacement([3, 4, 5], 3) == expected

test "combinationsWithReplacement([3, 4], 2) iterator":
  var result = newSeq[seq[int]](0)
  for c in combinationsWithReplacement([3, 4], 2):
    result.add(c)
  var expected = @[@[3, 3], @[3, 4], @[4, 4]]
  check result == expected

