defmodule GuidoWeb.MoviesCrawlers.MovieView do
  use GuidoWeb, :view

  def render("index.json", %{movies_schedule: movies_schedule}) do
    movies_schedule
  end
end
