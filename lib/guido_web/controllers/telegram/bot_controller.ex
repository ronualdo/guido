defmodule GuidoWeb.Telegram.BotController do
  use GuidoWeb, :controller

  alias Guido.Telegram

  def command(conn, params) do
    # Telegram.command(params["command"]).()
    render conn, "command.json"
  end
end
