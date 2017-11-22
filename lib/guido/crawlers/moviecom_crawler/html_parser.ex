defmodule Guido.Crawlers.MoviecomCrawler.HtmlParser do
  import Meeseeks.CSS

  def parse(content) do
    Meeseeks.parse(content)
    |> Meeseeks.all(css("div.tabela-programacao>table>tbody>tr"))
    |> Enum.map(&Meeseeks.tree/1)
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})
  end

  defp parse_line(line) do
    {extract_movie_title(line), extract_sessions(line)}
  end

  defp extract_movie_title(title_td_element) do
    result = title_td_element
    |> Meeseeks.one(css("div.programcao-filme-info>div.tit>a"))
    |> Meeseeks.text
    |> String.trim
    
    result
  end

  defp extract_sessions(session_tds) do
    session_tds
    |> Meeseeks.all(css("td.tabela-linha>table>tbody>tr"))
    |> Enum.map(&extract_session/1)
  end

  defp extract_session(input) do
    {extract_session_type(input), extract_schedule(input)} 
  end

  defp extract_session_type(session_type_td) do
    session_type_td
    |> Meeseeks.all(css("td>div.icon-tipo"))
    |> Enum.map(&Meeseeks.text/1)
  end

  defp extract_schedule(schedule_td) do
    schedule_td
    |> Meeseeks.all(css("div.icon-hora>a"))
    |> Enum.map(&Meeseeks.text/1)
  end
end
