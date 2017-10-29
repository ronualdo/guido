defmodule Guido.Crawlers.MoviecomCrawler.HtmlParser do
  def parse(content) do
    content
    |> Floki.find("div.tabela-programacao>table>tbody>tr")
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})
  end

  defp parse_line({_tr, _attrs, table_tds}) do
    {extract_movie_title(hd(table_tds)), extract_sessions(tl(table_tds))}
  end

  defp extract_movie_title(title_td_element) do
    title_td_element
    |> Floki.find("td.tabela-linha>div>div.programcao-filme-info>div.tit>a")
    |> Floki.text
    |> String.trim
  end

  defp extract_sessions(session_tds) do
    session_tds
    |> Floki.find("td.tabela-linha>table>tbody>tr")
    |> Enum.map(&extract_session/1)
  end

  defp extract_session({_tr, _attrs, table_tds}) do
    {extract_session_type(hd(table_tds)), extract_schedule(tl(table_tds))} 
  end

  defp extract_session_type(session_type_td) do
    session_type_td
    |> extract_text_from("td>div.icon-tipo")
  end

  defp extract_schedule(schedule_td) do
    schedule_td
    |> extract_text_from("div.icon-hora>a")
  end

  defp extract_text_from(input, selector) do
    input
    |> Floki.find(selector)
    |> Enum.map(&Floki.text/1)
  end
end
