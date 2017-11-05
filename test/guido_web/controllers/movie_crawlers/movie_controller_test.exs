defmodule Guido.MoviesCrawlers.MovieControllerTest do
  use GuidoWeb.ConnCase

  test '#index returns a summary of movies schedule', %{conn: conn} do
    result = get(conn, movie_path(conn, :index)) |> json_response(200)

    assert %{"moviecom"=> movies_schedule} = result
    assert Map.keys(movies_schedule) != []
    assert Map.values(movies_schedule) |> Enum.all?(&(Enum.count(&1) > 0))
  end
end
