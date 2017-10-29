defmodule Guido.Crawlers.MoviecomCrawlerTest do
  use ExUnit.Case
  use Timex

  alias Guido.Crawlers.MoviecomCrawler

  test "return error if gateway fails to retrieve info" do
    gateway = fn() -> {:error, "problem"} end

    schedule = MoviecomCrawler.extract_data(Timex.today, gateway)

    assert schedule == {:error, "problem"}
  end

  test "returns schedule" do
    gateway = &read_stub/0

    schedule = MoviecomCrawler.extract_data(Timex.today, gateway)
  
    assert schedule == %{
      "A Morte Te dá Parabéns" => [
        {["DUB"], ["15:50", "17:50", "19:50"]},
        {["LEG"], ["21:50"]}
      ],
      "As Aventuras do Capitão Cueca" => [
        {["DUB"], ["15:50", "19:35"]},
        {["DUB", "3D"], ["17:40"]}
      ],
      "Blade Runner 2049" => [
        {["DUB"], ["18:50"]},
        {["LEG"], ["21:00"]},
      ],
      "Chocante" => [
        {[], ["16:50", "22:00"]}
      ],
      "Como Se Tornar o Pior Aluno da Escola" => [
        {[], ["15:00", "17:15", "19:30", "21:45"]}
      ],
      "Entre Irmãs" => [
        {[],["14:50", "20:45"]}
      ],
      "IT: A Coisa" => [
        {["DUB"], ["18:40"]},
        {["DUB"], ["21:30"]}
      ],
      "Kingsman: O Círculo Dourado" => [
        {["DUB"], ["18:00"]},
        {["DUB"], ["21:20"]}
      ],
      "LEGO Ninjago: O Filme" => [
        {["DUB"], ["16:30"]}
      ],
      "My Little Pony: O Filme" => [
        {["DUB"], ["14:40"]}
      ],
      "Pica-Pau" => [
        {["DUB"], ["15:45", "17:30", "19:15"]}
      ],
    }
  end

  defp read_stub do
    body = File.read! "moviecom.html"
    {:ok, body}
  end
end
