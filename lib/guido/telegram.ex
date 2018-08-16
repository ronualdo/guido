defmodule Guido.Telegram do

  alias Guido.Telegram.BotParser
  alias Guido.Telegram.BotApiGateway

  def answer_inline_query(%{"id" => inline_query_id, "query" => "movies"}, movies_data) do
    movies_data
    |> BotParser.parse_theater_schedule
    |> BotParser.build_movies_inline_query_answer(inline_query_id)
    |> BotApiGateway.answer_inline_query
  end

  def answer_inline_query(_query, _movies_data), do: nil
end
