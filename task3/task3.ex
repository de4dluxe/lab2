{n, ""} = IO.gets("") |> String.trim() |> Integer.parse()

numbers =
  for _ <- 1..n do
    line = IO.gets("") |> String.trim()

    unless String.match?(line, ~r/^\d+$/) do
      raise "Символ должен быть цифрой"
    end

    line
  end

results =
  Enum.map(numbers, fn s ->
    if String.length(s) == 1 do
      "-"
    else
      counter =
        s
        |> String.to_charlist()
        |> Enum.count(fn code -> rem(code, 2) == 0 end)

      Integer.to_string(counter)
    end
  end)

IO.puts(Enum.join(results, " "))