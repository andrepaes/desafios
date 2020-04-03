defmodule Problem4 do
  def problem_4 do
    Enum.reduce(100..999, [], fn i, tasks ->
      loop_though_j(i) ++ tasks
      |> Enum.sort(&(&1[:num] > &2[:num]))
    end)
    |> Enum.take(1)
  end

  def loop_though_j(i) do
    Enum.reduce(999..100, [], fn j, tasks ->
      num_list = Integer.digits(i * j)
      [
        Task.async(
          fn ->
            %{i: i, j: j, num: i * j, palindrome?: palindrome?(num_list)}
          end) |
        tasks
      ]
    end)
    |> Enum.map(fn task -> Task.await(task) end)
    |> Enum.filter(fn map -> map[:palindrome?] == true end)
  end

  def palindrome?(number_list), do: equal?(number_list, Enum.reverse(number_list))

  def equal?(list_1, list_2) when length(list_1) > 0 and length(list_2) > 0 do
    [hd | tl] = list_1
    [hd_2 | tl_2] = list_2
    if hd == hd_2 do
      equal?(tl, tl_2)
    else
      false
    end
  end

  def equal?(list_1, list_2) when length(list_1) > 0 or length(list_2) > 0, do: false
  def equal?(list_1, list_2) when length(list_1) == 0 and length(list_2) == 0, do: true
end