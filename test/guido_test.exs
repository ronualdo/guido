defmodule GuidoTest do
  use ExUnit.Case
  use Timex

  test 'returns an empty when no crawlers are provided' do
    schedule = Guido.movies_schedule(%{})

    assert schedule == %{}
  end

  test 'returns formatted schedule based on crawlers result' do
    theater1_schedule = %{
      movie1: [
        parse_default_format!("2017-10-20 10:00:00Z"),
        parse_default_format!("2017-10-20 10:00:00Z")
      ],
      movie2: [
        parse_default_format!("2017-10-20 10:00:00Z")
      ]
    }
    crawler_function = fn(_date) -> theater1_schedule end

    schedule = Guido.movies_schedule(%{theather1: crawler_function})

    assert schedule == %{theather1: theater1_schedule}
  end

  test 'omits theather if parse raises exception' do
    theater1_schedule = %{
      movie1: [
        parse_default_format!("2017-10-20 10:00:00Z")
      ]
    }
    theater1_crawler_function = fn(_date) -> theater1_schedule end
    theater2_crawler_function = fn(_date) -> raise "error message" end

    schedule = Guido.movies_schedule(%{
      theater1: theater1_crawler_function,
      theater2: theater2_crawler_function
    })

    assert schedule == %{
      theater2: {:error, "error message"},
      theater1: theater1_schedule
    }
  end

  defp parse_default_format!(string_time) do
    Timex.parse!(string_time, "{YYYY}-{0M}-{D} {h24}:{m}:{s}{Zname}")
  end
end
