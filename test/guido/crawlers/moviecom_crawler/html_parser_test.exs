defmodule Guido.Crawlers.MoviecomCrawler.HtmlParserTest do
  use ExUnit.Case

  alias Guido.Crawlers.MoviecomCrawler.HtmlParser

  @tag :integration
  test "returns data extracted from provided content" do
    data = HtmlParser.parse(read_stub())

    assert data == %{
      "Pica-Pau" => [
        {["DUB"], ["15:35"]}
      ],
      "A Comédia Divina" => [
        {[], ["14:30", "16:40"]}
      ],
      "As Aventuras do Capitão Cueca" => [
        {["DUB"], ["14:10"]},
      ],
      "A Noiva" => [
        {["DUB"], ["16:00", "18:00", "20:00"]},
        {["LEG"], ["22:00"]},
      ],
      "Além da Morte" => [
        {["DUB"], ["22:00"]}
      ],
      "Como Se Tornar o Pior Aluno da Escola" => [
        {[], ["20:00"]}
      ],
      "Big Pai, Big Filho" => [
        {["DUB"],["14:05", "16:00", "17:55"]}
      ],
      "Depois Daquela Montanha" => [
        {["DUB"], ["17:20", "19:35"]},
        {["LEG"], ["21:50"]}
      ],
      "Historietas Assombradas" => [
        {[], ["14:30", "16:20", "18:10"]}
      ],
      "Missão Cegonha" => [
        {["DUB"], ["13:50"]}
      ],
      "Tempestade: Planeta em Fúria" => [
        {["DUB"], ["19:50"]}
      ],
      "Thor: Ragnarok" => [
        {["DUB"], ["14:00", "16:35", "19:10", "21:45"]},
        {["DUB", "3D"], ["15:00", "17:40"]},
        {["DUB"], ["18:45"]},
        {["LEG", "3D"], ["20:20"]},
        {["LEG"], ["21:20"]}
      ],
    }
  end

  defp read_stub, do: File.read! "moviecom.html"
end
