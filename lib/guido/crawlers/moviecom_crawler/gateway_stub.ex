defmodule Guido.Crawlers.MoviecomCrawler.GatewayStub do
  def pull_data do
    {:ok, File.read! "moviecom.html"}
  end
end
