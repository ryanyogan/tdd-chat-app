defmodule ChatterWeb.Router do
  use ChatterWeb, :router
  alias ChatterWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChatterWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatterWeb do
    pipe_through :browser

    get "/sign_in", SessionController, :new
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/", ChatterWeb do
    pipe_through [:browser, Plugs.RequireLogin]

    resources "/chat_rooms", ChatRoomController, only: [:new, :create, :show]
    get "/", ChatRoomController, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ChatterWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
