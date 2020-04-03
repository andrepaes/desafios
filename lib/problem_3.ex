defmodule Problem3 do
  def problem3(val) do
    divisors(val)
    |> Map.keys()
    |> Enum.max()
  end
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