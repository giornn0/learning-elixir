defmodule Josephus do
  @moduledoc """
  The Josephus problem's mathematical solution is based on a clever recursive pattern. Here's a detailed breakdown:

  Recursive Pattern:


  When n people are in a circle, and every kth person is eliminated, the survivor's position follows a recursive relationship.
  At each step, the problem reduces to a smaller circle with one less person.
  The key insight is mapping the survivor's position from n-1 people to n people.


  Mathematical Recurrence:


  Let f(n,k) be the survivor's position for n people
  f(1,k) = 1 (base case)
  f(n,k) = (f(n-1,k) + k - 1) % n + 1


  f(7,3) = (f(6,3) + 3 - 1) % 7 + 1
  f(6,3) = (f(5,3) + 3 - 1) % 6 + 1
  f(5,3) = (f(4,3) + 3 - 1) % 5 + 1
  f(4,3) = (f(3,3) + 3 - 1) % 4 + 1
  f(3,3) = (f(2,3) + 3 - 1) % 3 + 1
  f(2,3) = (f(1,3) + 3 - 1) % 2 + 1
  f(1,3) = 1

  f(7,3) = (f(6,3) + 3 - 1) % 7 + 1
  f(6,3) = (f(5,3) + 3 - 1) % 6 + 1
  f(5,3) = (f(4,3) + 3 - 1) % 5 + 1
  f(4,3) = (f(3,3) + 3 - 1) % 4 + 1
  f(3,3) = (f(2,3) + 3 - 1) % 3 + 1
  f(2,3) = ( 1 + 3 - 1) % 2 + 1

  f(7,3) = (1 + 3 - 1) % 7 + 1 = 4
  f(6,3) = (4 + 3 - 1) % 6 + 1 = 1
  f(5,3) = (1 + 3 - 1) % 5 + 1 = 4
  f(4,3) = (2 + 3 - 1) % 4 + 1 = 1
  f(3,3) = (2 + 3 - 1) % 3 + 1 = 2
  f(2,3) = (1 + 3 - 1) % 2 + 1 = 2

  Intuition Behind the Formula:


  After eliminating a person, the circle's indexing shifts
  The + k - 1 accounts for the elimination step
  The % n handles circular wrapping
  The + 1 adjusts to 1-based indexing


  Time Complexity Improvement:


  Original approach: O(n²)
  Mathematical solution: O(n)
  Eliminates expensive list operations and filtering
  """
  def survivor(n, _) when n == 1, do: 1
  def survivor(n, k) when k == 1, do: n

  def survivor(n, k) do
    1..n |> Enum.to_list() |> resolver(k, 0, n)
  end

  def resolver([survivor], _, _, 1), do: survivor

  def resolver(list, k, offset, size) do
    {dead, index} = list |> Enum.with_index() |> get_dead(k, offset, size)

    new_offset = size - index - 1

    list
    |> Enum.filter(fn v -> v != dead end)
    |> resolver(k, new_offset, size - 1)
  end

  def get_dead(list, k, offset, size) do
    take =
      case size > k do
        true -> size
        _ -> k + offset
      end

    list |> Stream.cycle() |> Enum.take(take) |> Enum.at(k - offset - 1)
  end

  @doc """
    #Mathematical solution:
   This recursive mathematical solution has:
   O(n) time complexity
   O(n) space complexity (due to recursion)
   Much faster than the original list-based implementation
   Eliminates list filtering and cycling
  """
  def survivor_math(n, k) do
    do_survivor(n, k)
  end

  defp do_survivor(1, _), do: 1

  defp do_survivor(n, k) do
    (do_survivor(n - 1, k) + k - 1) |> rem(n) |> Kernel.+(1)
  end

  @doc """
    #Iterative version (even more efficient):
  This version has:
  O(n) time complexity
  O(1) space complexity
  No recursion overhead
  More memory-efficient
  """
  def survivor_iter(n, k) do
    survivor_iter(n, k)
  end

  defp survivor_iter(n, k) do
    Enum.reduce(2..n, 1, fn count, acc ->
      rem(acc + k - 1, count) + 1
    end)
  end
end

# defmodule TestSolution do
#   use ExUnit.Case
#
#   # TODO: Replace examples and use TDD development by writing your own tests
#   test "some test description" do
#     assert Josephus.survivor(7, 3) == 4
#     assert Josephus.survivor(11, 19) == 10
#     assert Josephus.survivor(1, 300) == 1
#     assert Josephus.survivor(14, 2) == 13
#     assert Josephus.survivor(100, 1) == 100
#   end
# end
# k -> 2
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14
# 1 3 4 5 6 7 8 9 10 11 12 13 14
# 1 3 5 6 7 8 9 10 11 12 13 14
# 1 3 5 7 8 9 10 11 12 13 14
# 1 3 5 7 9 10 11 12 13 14
# 1 3 5 7 9 11 12 13 14
# 1 3 5 7 9 11 13 14
# 1 3 5 7 9 11 13
# 1 5 7 9 11 13
# 1 5 9 11 13
# 1 5 9 13
# 5 9 13
# 5 13
# 13

# k -> 4
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14
# 1 2 3 5 6 7 8 9 10 11 12 13 14
# 1 2 3 5 6 7 9 10 11 12 13 14
# 1 2 3 5 6 7 9 10 11 13 14
# 1 3 5 6 7 9 10 11 13 14
# 1 3 5 6 9 10 11 13 14
# 1 3 5 6 9 10 11 14
# 1 3 6 9 10 11 14
# 1 3 6 9 10 14
# 1 3 9 10 14
# 3 9 10 14
# 3 9 10
# 9 10
# 9 -> survivor

# k -> 19
# 1 2 3 4 5 6 7 8 9 10 11 1 2 3 4 5 6 7 8 9 10 11
# 1 2 3 4 5 6 7 9 10 11 1 2 3 4 5 6 7 9 10 11 -> 8 = |19(k) - 11(restantes) - 0(offset)|
# 1 2 3 4 5 7 9 10 11 -> 6  = |19(k) - 10(restantes) - 3(offset)|
# 1 2 3 4 5 9 10 11 -> 7 = |19(k) - (9(restantes) - 4(offset) X 2 -> 19 - 9 < 9)|
# 1 2 3 4 5 9 10 -> 11 = 19 - 16 - 6
# 1 2 3 4 9 10 -> 5
# 1 2 3 4 10 -> 9
# 1 2 4 10 -> 3
# 2 4 10 -> 1
# 4 10 -> 2
# 10 -> 4
# 10 -> survivor
