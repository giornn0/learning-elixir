defmodule SumOfOdd do
  def row_sum_odd_numbers(n) when n == 1, do: 1

  def row_sum_odd_numbers(n) do
    plus = n + 1
    start = n * (n - 1) + 1
    last = plus * n - 1
    Enum.to_list(start..last//2) |> Enum.sum()
  end

  def row_sum_odd_numbers_clever(n) do
    n * n * n
  end
end
