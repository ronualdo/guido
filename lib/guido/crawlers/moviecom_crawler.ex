defmodule Guido.Crawlers.MoviecomCrawler do
  def extract_data(_date, gateway) do
    gateway.()
    |> parse
  end

  defp parse(input={:error, _}) do
    input
  end

  defp parse({:ok, content}) do
    content
    |> Floki.find("div.tabela-programacao>table>tbody>tr")
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})
  end

  defp parse_line(line) do
    {extract_movie_title(line), extract_sessions(line)}
  end

  defp extract_movie_title({_elem, _attrs, children}) do
    children
    |> hd
    |> Floki.find("td.tabela-linha>div>div.programcao-filme-info>div.tit>a")
    |> Floki.text
    |> String.trim
  end

  defp extract_sessions({_elem, _attrs, children}) do
    children
    |> second_element
    |> Floki.find("td.tabela-linha>table>tbody>tr")
    |> Enum.map(&extract_session/1)
  end

  defp extract_session(session_line) do
    {extract_session_type(session_line), extract_schedule(session_line)} 
  end

  defp second_element(list) do
    [_first | [second | _tail]] = list
    second
  end

  defp third_element(list) do
    [_first | [_second | tail]] = list
    tail
  end

  defp extract_session_type(session_line) do
    session_line
    |> Floki.find("td:first-child")
    |> Enum.map(&(&1 |> Floki.find("td>div.icon-tipo")))
    |> Enum.flat_map(&extract_type/1)
  end

  defp extract_type([]) do
    [""]
  end

  defp extract_type(div) do
    div
    |> Enum.map(&Floki.text/1)
  end

  defp extract_schedule({_elem, _attrs, children}) do
    children
    |> third_element
    |> Floki.find("div.icon-hora>a")
    |> Enum.map(&Floki.text/1)
  end
end
