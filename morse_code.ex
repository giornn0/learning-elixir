defmodule MorseCode do
  # Defines @morse_codes
  # use MorseCode.Constants

  @morse_codes %{
    "...." => "H",
    "." => "E",
    "-.--" => "Y",
    ".---" => "J",
    "..-" => "U",
    "-.." => "D"
  }
  def decode(code) do
    code
    |> String.trim()
    |> String.split(" ")
    |> Enum.map_join("", fn encoded ->
      case @morse_codes[encoded] do
        nil -> " "
        val -> val
      end
    end)
    |> String.replace("  ", " ")
  end
end
