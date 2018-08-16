defmodule Guido.Telegram.BotApiGateway do
  def answer_inline_query(message) do
    answer_inline_query_url()
    |> HTTPoison.post(Poison.encode!(message), [{"Content-Type", "application/json"}])
  end

  defp answer_inline_query_url do
    "https://api.telegram.org/bot#{bot_token()}/answerInlineQuery"
  end

  defp bot_token, do: System.get_env("TELEGRAM_BOT_TOKEN")
end
