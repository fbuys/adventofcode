defmodule Two.Part1 do
  @doc """
    Rules
    ===
    Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock.

    We codified openent and player moves as follows:

    ## Oponent moves
    A => Rock
    B => Paper
    C => Scissors

    ## Player moves
    X => Rock
    Y => Paper
    Z => Scissors

    You score points when you win and bonus points depend on the move you won with.

    ## Match match points
    Win => 6
    Draw => 3
    Lose => 0

    ## Bonus points
    A => 1
    B => 2
    C => 3
  """

  @rock 1
  @paper 2
  @scissor 3
  @win 6
  @draw 3
  @loss 0

  @spec tally(rounds :: [String.t()]) :: integer()
  def tally(rounds) do
    rounds
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&get_score(&1))
    |> Enum.sum()
  end

  # private

  @spec get_score(String.t()) :: integer()
  defp get_score(<<opponent::8, _space::8, player::8>>) do
    match_points(opponent, player) + bonus_points(player)
  end

  @spec match_points(oponent_move :: byte(), player_move :: byte()) :: integer()
  defp match_points(?A, ?Y), do: @win
  defp match_points(?A, ?Z), do: @loss
  defp match_points(?B, ?X), do: @loss
  defp match_points(?B, ?Z), do: @win
  defp match_points(?C, ?X), do: @win
  defp match_points(?C, ?Y), do: @loss
  defp match_points(_oponent, _player), do: @draw

  @spec bonus_points(player_move :: byte()) :: integer()
  defp bonus_points(?X), do: @rock
  defp bonus_points(?Y), do: @paper
  defp bonus_points(?Z), do: @scissor
end
