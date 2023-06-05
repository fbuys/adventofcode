defmodule Two.Part2 do
  @doc """
    Rules
    ===
    Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock.

    We codified openent and player moves as follows:

    ## Oponent moves
    A => Rock
    B => Paper
    C => Scissors

    ## Desired result
    X => Lose
    Y => Draw
    Z => Win

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
  defp get_score(<<opponent::8, _space::8, result::8>>) do
    match_points(result) + bonus_points(opponent, result)
  end

  @spec match_points(result :: byte()) :: integer()
  defp match_points(?X), do: @loss
  defp match_points(?Y), do: @draw
  defp match_points(?Z), do: @win

  @spec bonus_points(player_move :: byte(), desired_result :: byte()) :: integer()
  defp bonus_points(?A, ?X), do: @scissor
  defp bonus_points(?B, ?X), do: @rock
  defp bonus_points(?C, ?X), do: @paper
  defp bonus_points(?A, ?Y), do: @rock
  defp bonus_points(?B, ?Y), do: @paper
  defp bonus_points(?C, ?Y), do: @scissor
  defp bonus_points(?A, ?Z), do: @paper
  defp bonus_points(?B, ?Z), do: @scissor
  defp bonus_points(?C, ?Z), do: @rock
end
