defmodule ATM do
  def withdraw(amount) do
    hundreds = amount |> div(100)
    rest = amount |> rem(100)
    [rest_first_digit | _] = rest |> Integer.digits()

    case rest_first_digit |> rem(2) == 0 do
      true -> [hundreds, 0, rest |> div(20)]
      false -> withdraw(hundreds, rest_first_digit)
    end
  end

  def withdraw(hundreds, rest_first_digit) when rest_first_digit == 1, do: [hundreds - 1, 1, 3]
  def withdraw(hundreds, rest_first_digit) when rest_first_digit == 3, do: [hundreds - 1, 1, 4]
  def withdraw(hundreds, rest_first_digit) when rest_first_digit == 5, do: [hundreds, 1, 0]
  def withdraw(hundreds, rest_first_digit) when rest_first_digit == 7, do: [hundreds, 1, 1]
  def withdraw(hundreds, rest_first_digit) when rest_first_digit == 9, do: [hundreds, 1, 2]

  def withdraw_improved(n) when rem(n, 20) != 0, do: _withdraw(n - 50, 1)
  def withdraw_improved(n), do: _withdraw(n, 0)
  defp _withdraw(n, n50), do: [n |> div(100), n50, n |> rem(100) |> div(20)]
end
