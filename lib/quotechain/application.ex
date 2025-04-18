defmodule Quotechain.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      QuotechainWeb.Telemetry,
      Quotechain.Repo,
      {DNSCluster, query: Application.get_env(:quotechain, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Quotechain.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Quotechain.Finch},
      # Start a worker by calling: Quotechain.Worker.start_link(arg)
      # {Quotechain.Worker, arg},
      # Start to serve requests, typically the last entry
      QuotechainWeb.Endpoint,
      {AshAuthentication.Supervisor, [otp_app: :quotechain]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Quotechain.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuotechainWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
