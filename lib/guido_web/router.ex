defmodule GuidoWeb.Router do
  use GuidoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GuidoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", GuidoWeb do
    pipe_through :api

    get "/movies", MoviesCrawlers.MovieController, :index
    post "/command", Telegram.BotController, :command
  end
end
