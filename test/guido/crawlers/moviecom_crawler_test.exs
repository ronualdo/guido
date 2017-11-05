defmodule Guido.Crawlers.MoviecomCrawlerTest do
  use ExUnit.Case
  use Timex

  alias Guido.Crawlers.MoviecomCrawler

  test "return error if gateway fails to retrieve info" do
    gateway = fn() -> {:error, "problem"} end

    schedule = MoviecomCrawler.extract_data(gateway)

    assert schedule == {:error, "problem"}
  end
end
