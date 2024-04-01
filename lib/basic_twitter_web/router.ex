defmodule BasicTwitterWeb.Router do
  use BasicTwitterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BasicTwitterWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BasicTwitterWeb do
    pipe_through :browser

    live "/", TweetLive.Index, :index
    live "/tweets", TweetLive.Index, :index
    live "/tweets/new", TweetLive.Index, :new
    live "/tweets/:id/edit", TweetLive.Index, :edit

    live "/tweets/:id", TweetLive.Show, :show
    live "/tweets/:id/show/edit", TweetLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", BasicTwitterWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:basic_twitter, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BasicTwitterWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
