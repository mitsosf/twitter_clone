defmodule BasicTwitter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BasicTwitterWeb.Telemetry,
      BasicTwitter.Repo,
      {DNSCluster, query: Application.get_env(:basic_twitter, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BasicTwitter.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BasicTwitter.Finch},
      # Start a worker by calling: BasicTwitter.Worker.start_link(arg)
      # {BasicTwitter.Worker, arg},
      # Start to serve requests, typically the last entry
      BasicTwitterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BasicTwitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BasicTwitterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
