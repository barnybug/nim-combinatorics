import combinatorics
import unittest

test "nPk":
  check nPk(3, 2) == 6
  check nPk(10, 2) == 90

test "nCk":
  check nCk(3, 2) == 3
  check nCk(10, 2) == 45
