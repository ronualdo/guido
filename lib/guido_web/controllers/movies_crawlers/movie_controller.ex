defmodule GuidoWeb.MoviesCrawlers.MovieController do
  use GuidoWeb, :controller

  @crawler_mapping %{moviecom: &Guido.Crawlers.MoviecomCrawler.extract_data/1}

  def index(conn, _params) do
    render conn, "index.json", %{movies_schedule: Guido.movies_schedule(@crawler_mapping)}
  end
end
