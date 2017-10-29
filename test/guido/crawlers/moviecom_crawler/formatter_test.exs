defmodule Guido.Crawlers.MoviecomCrawler.FormatterTest do
  use ExUnit.Case

  alias Guido.Crawlers.MoviecomCrawler.Formatter

  test "returns an empty hash when no input is provided" do
    assert Formatter.format(%{}) == %{}
  end

  test "formats movie title when it has only one session" do
    result = Formatter.format(%{"Movie 1" => [{["DUB"], ["17:00"]}]})
    assert result == %{"Movie 1 DUB" => ["17:00"]}
  end

  test "formats movie title when it has different sessions" do
    result = Formatter.format(
      %{"Movie" => [
        {["DUB"], ["13:00"]},
        {["LEG"], ["11:00"]}
      ]}
    )

    assert result = %{"Movie DUB" => ["13:00"], "Movie LEG" => ["11:00"]}
  end

  test "formats title with multiple session description" do
    result = Formatter.format(%{"Movie 1" => [{["LEG 3D"], ["17:00"]}]})
    assert result == %{"Movie 1 LEG 3D" => ["17:00"]}
  end

  test "formats movie without descriptions" do
    result = Formatter.format(%{"Movie 1" => [{[], ["17:00"]}]})
    assert result == %{"Movie 1" => ["17:00"]}
  end

  test "aggregates sessions with same descriptions for the same movie" do
    result = Formatter.format(%{
      "Movie 1" => [
        {["DUB"], ["13:00", "15:00"]},
        {["DUB"], ["21:00"]}
      ]
    })

    assert result == %{"Movie 1 DUB" => ["13:00", "15:00", "21:00"]}
  end
end
