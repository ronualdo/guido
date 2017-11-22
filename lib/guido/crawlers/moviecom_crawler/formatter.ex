defmodule Guido.Crawlers.MoviecomCrawler.Formatter do

  def format(input = {:error, _message}), do: input

  def format(input) do
    input
    |> Enum.flat_map(&format_movie_schedule/1)
    |> Enum.group_by(&(elem(&1, 0)), &(elem(&1, 1)))
    |> Enum.map(&flatten_schedule/1)
    |> Enum.into(%{})
  end

  defp format_movie_schedule({movie_title, {session_type, schedule}}) do
    formatted_movie_title = session_type
    |> Enum.reduce(movie_title, &("#{&2} #{&1}"))

    {formatted_movie_title, schedule}
  end

  defp format_movie_schedule({movie_title, schedules}) do
    schedules
    |> Enum.map(&(format_movie_schedule({movie_title, &1})))
  end

  defp flatten_schedule({movie, schedule}) do
    {movie, Enum.flat_map(schedule, &(&1))}
  end
end
