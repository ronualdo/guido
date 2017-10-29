defmodule Guido.Crawlers.MoviecomCrawler do

  alias Guido.Crawlers.MoviecomCrawler.HtmlParser

  def extract_data(_date, gateway) do
    gateway.()
    |> parse
  end

  defp parse(input={:error, _}), do: input

  defp parse({:ok, content}), do: HtmlParser.parse(content) 
end
