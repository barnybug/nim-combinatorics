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
