defmodule Guido.Crawlers.MoviecomCrawler do

  alias Guido.Crawlers.MoviecomCrawler.HtmlParser
  alias Guido.Crawlers.MoviecomCrawler.Formatter

  def extract_data(gateway) do
    gateway.() |> parse |> Formatter.format
  end

  defp parse(input={:error, _}), do: input

  defp parse({:ok, content}), do: HtmlParser.parse(content) 
end
