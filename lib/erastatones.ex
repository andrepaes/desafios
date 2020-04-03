defmodule SieveOfErastatones do
  def sieve_of_erastatones(val), do: sieve_of_erastatones(val, [], Enum.to_list(2..val))
  def sieve_of_erastatones(val, primes, numbers) when length(numbers) > 0 do
    [hd | tl] = numbers
    case divisor?(primes, hd) do
       true -> sieve_of_erastatones(val, primes, tl)
       false ->
         new_primes = primes ++ [hd]
         sieve_of_erastatones(val, new_primes,tl)
    end
  end

  def sieve_of_erastatones(_, primes, numbers) when length(numbers) == 0,
      do: primes

  def divisor?(primes, val) do
    Enum.reduce(primes, [], fn prime, acc ->
      [Task.async(fn -> rem(val, prime) == 0 end) | acc]
    end)
    |> Enum.map(fn task -> Task.await(task) end)
    |> Enum.filter(fn n -> n == true end)
    |> case do
          [] -> false
          _ -> true
       end
  end
end