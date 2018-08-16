defmodule Guido.Telegram.BotParserTest do
  use ExUnit.Case

  alias Guido.Telegram.BotParser

  test "parse movie schedule without any sessions data" do
    movie_schedule = {"X-men 2", []}
    result = BotParser.parse_movie_schedule(movie_schedule)
    assert result == "X-men 2 []"
  end

  test "parse movie schedule with sessions data" do
    movie_schedule = {"X-men 2", ["12:00", "18:35"]}
    result = BotParser.parse_movie_schedule(movie_schedule)
    assert result == "X-men 2 [12:00, 18:35]"
  end

  test "parse theater schedule when movie schedule is not found" do
    theater_schedule = %{"theater name" => %{}}
    result = BotParser.parse_theater_schedule(theater_schedule)
    assert result == "theater name\nNão foram encontrados dados de filmes"
  end

  test "parse theater schedule with movie schedule" do
    theater_schedule = %{"theater name" => %{"movie name" => ["10:00", "16:25"]}}
    result = BotParser.parse_theater_schedule(theater_schedule)
    assert result == "theater name\nmovie name [10:00, 16:25]"
  end

  test "parse theater schedule with multiple movies schedule" do
    theater_schedule = %{
      "theater name" => %{
        "movie name" => ["10:00", "16:25"],
        "movie name 2" => ["9:23"]
      }
    }

    result = BotParser.parse_theater_schedule(theater_schedule)
    assert result == "theater name\nmovie name [10:00, 16:25]\nmovie name 2 [9:23]"
  end

  test "parse multiple theaters schedule with multiple movies schedule" do
    theater_schedule = %{
      "theater name" => %{
        "movie name" => ["10:00", "16:25"],
        "movie name 2" => ["9:23"]
      },
      "theater name 2" => %{
        "movie name 3" => ["21:45"]
      }
    }

    result = BotParser.parse_theater_schedule(theater_schedule)

    assert result ==
             "theater name\n" <>
               "movie name [10:00, 16:25]\n" <>
               "movie name 2 [9:23]\ntheater name 2\nmovie name 3 [21:45]"
  end

  test "build movies inline query answer" do
    result = BotParser.build_movies_inline_query_answer("test content", 1)

    assert %{
      inline_query_id: 1,
      results: [
        %{
          type: "article",
          id: 1,
          title: "Filmes",
          input_message_content: %{message_text: "test content"}
        }
      ]
    } = result
  end
end
