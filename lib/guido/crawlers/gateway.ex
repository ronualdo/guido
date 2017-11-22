defmodule Guido.Crawlers.Gateway do
  def pull_data do
    {:ok, retrieve_data().body}
  end

  defp retrieve_data do
    "http://moviecom.com.br/programacao/"
    |> HTTPoison.get!(%{}, hackney: [cookie: ["praca=MNT"]])
  end
end
