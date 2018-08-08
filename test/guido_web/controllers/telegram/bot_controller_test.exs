defmodule GuidoWeb.Telegram.BotControllerTest do
  use GuidoWeb.ConnCase

  @tag :acceptance
  test "should return success when receive command", %{conn: conn} do
    post(conn, bot_path(conn, :command)) |> json_response(200)
  end
end
