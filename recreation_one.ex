defmodule RecreationOne do
  def list_squared(m, n) do
    m..n
    |> Stream.map(&get_divisors_squared_sum(&1))
    |> Stream.filter(fn {_, sum} ->
      square = :math.sqrt(sum)
      square - (square |> round()) == 0
    end)
    |> Enum.to_list()
  end

  def get_divisors_squared_sum(n) when n == 1, do: {1, 1}

  def get_divisors_squared_sum(n) do
    sum =
      1..((n / 2)
          |> round())
      |> Stream.filter(&(n |> rem(&1) == 0))
      |> Stream.map(&(&1 ** 2))
      |> Enum.sum()

    {n, sum + n ** 2}
  end

  # INFO: 
  # Only thing to improve is to short the range working with
  # the square of the number
  #     1..(:math.sqrt(num) |> trunc)
  # |> Enum.filter(&(rem(num, &1) == 0))
  # |> Enum.reduce(0, fn x, acc -> 
  #     r = div(num, x)
  #     if x == r, do: acc + x*x, else: acc + x*x + r*r
  # end)
end

# defmodule TestSolution do
#   use ExUnit.Case
#
#   test "Example Tests" do
#     assert RecreationOne.list_squared(1, 250) == [{1, 1}, {42, 2500}, {246, 84100}]
#     assert RecreationOne.list_squared(42, 250) == [{42, 2500}, {246, 84100}]
#     assert RecreationOne.list_squared(250, 500) == [{287, 84100}]
#   end
# end
#
#
