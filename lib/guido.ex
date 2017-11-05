defmodule Guido do
  @moduledoc """
  Guido keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  use Timex

  @gateway Application.get_env(:guido, :gateway)

  def movies_schedule(crawler_mapping) do
    crawler_mapping
    |> Enum.map(&run_crawler/1)
    |> Enum.into(%{})
  end

  defp run_crawler({key, crawler_function}) do
    {key, crawler_function.(&@gateway.pull_data/0)}
  rescue
    e -> {key, {:error, e.message}}
  end
end
