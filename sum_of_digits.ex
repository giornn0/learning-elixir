defmodule Kata do
  def digital_root(n) do
    resolve(n)
  end

  def resolve(number) when is_number(number) and number < 10,
    do: number

  def resolve(number) when is_number(number) and number >= 10,
    do: number |> Integer.digits() |> Enum.sum() |> resolve()

  def digital_root_improved(n), do: rem(n - 1, 9) + 1
end
