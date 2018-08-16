defmodule Guido.Telegram.BotParser do
  def parse_movie_schedule({movie_title, schedule}) do
    parsed_schedule = Enum.join(schedule, ", ")
    "#{movie_title} [#{parsed_schedule}]"
  end

  def parse_theater_schedule(theater_schedule) do
    theater_schedule
    |> Enum.map(fn {theater, schedule} ->
      "#{theater}\n#{parse_theater_schedule_temp(schedule)}"
    end)
    |> Enum.join("\n")
  end

  def parse_theater_schedule_temp(schedule) when schedule == %{} do
    "Não foram encontrados dados de filmes"
  end

  def parse_theater_schedule_temp(schedule) do
    schedule
    |> Enum.map(&parse_movie_schedule/1)
    |> Enum.join("\n")
  end

  defp build_movies_inline_query_result(nil), do: nil

  defp build_movies_inline_query_result(content) do
    %{
      type: "article",
      id: 1,
      title: "Filmes",
      input_message_content: %{message_text: content}
    }
  end

  def build_movies_inline_query_answer(content, inline_query_id) do
    %{
      inline_query_id: inline_query_id,
      results: [build_movies_inline_query_result(content)]
    }
  end
end
