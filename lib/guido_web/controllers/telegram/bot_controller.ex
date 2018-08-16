defmodule GuidoWeb.Telegram.BotController do
  use GuidoWeb, :controller

  alias Guido.Telegram

  @crawler_mapping %{moviecom: &Guido.Crawlers.MoviecomCrawler.extract_data/1}

  def command(conn, params) do
    process(params)
    render conn, "command.json"
  end

  defp process(%{"inline_query" => inline_query}) do
    Telegram.answer_inline_query(inline_query, movies_data())
  end

  defp process(_), do: nil

  defp movies_data do
    Guido.movies_schedule(@crawler_mapping)
  end
end
