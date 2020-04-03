defmodule Problem501 do

#  def problem_501(val), do: problem_501(val, 1, 0)
#  def problem_501(val, i, acc) when i <= val do
#    divisors_list = Map.to_list(divisors(i))
#    case divisors_quantity(divisors_list) do
#      qty when qty == 8 -> problem_501(val, i + 1, acc + 1)
#      qty -> problem_501(val, i + 1, acc)
#    end
#  end
#
#  def problem_501(val, _, acc), do: acc

  def problem_501(val) do
    init = DateTime.utc_now()
    Enum.reduce(1..val, [], fn i, tasks ->
      [Task.async(fn -> get_quantity(i) end) | tasks]
    end)
    |> Enum.map(fn task -> Task.await(task, :infinity) end)
    |> Enum.frequencies()
    |> Map.get(8)

    DateTime.utc_now()
    |> DateTime.diff(init)
    |> IO.inspect
  end

  def get_quantity(i) do
    divisors_list = Map.to_list(divisors(i))
    qty = divisors_quantity(divisors_list)
  end

  def divisors_quantity(divisors_list),
      do: divisors_quantity(divisors_list, 1)
  def divisors_quantity(divisors_list, quantity) when length(divisors_list) > 0 do
    [hd | tl] = divisors_list
    {_, pow_number} = hd
    new_quantity = quantity * (pow_number + 1)
    divisors_quantity(tl, new_quantity)
  end

  def divisors_quantity(divisors_list, quantity) when length(divisors_list) == 0,
      do: quantity

  def divisors(val), do: divisors(val, 2, %{})
  def divisors(val, divisor, map) when val > 1 do
    case rem(val, divisor) do
      0 ->
        new_val = div(val, divisor)
        new_map =
          case Map.has_key?(map, divisor) do
            true ->
             pow_number = Map.get(map, divisor)
             Map.put(map, divisor,pow_number + 1)
           false -> Map.put(map, divisor, 1)
        end
        divisors(new_val, divisor, new_map)
      _ -> divisors(val, next_prime(divisor), map)
    end
  end

  def divisors(val, _, map) when val <= 1 , do: map

  def next_prime(n) do
    case is_prime?(n + 1) do
       true -> n + 1
       false -> next_prime(n + 1)
    end
  end

  def is_prime?(number), do: is_prime?(number, 2)
  def is_prime?(number, k) when k <= number / 2 do
    case number do
       val when rem(val, k) == 0 -> false
       _ -> is_prime?(number, k + 1)
    end
  end

  def is_prime?(_, _), do: true
end