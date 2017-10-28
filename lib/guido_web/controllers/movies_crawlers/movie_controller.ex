defmodule GuidoWeb.MoviesCrawlers.MovieController do
  use GuidoWeb, :controller

  def index(conn, _params) do
    render conn, "index.json"
  end
end
