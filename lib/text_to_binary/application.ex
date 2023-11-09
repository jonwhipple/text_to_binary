defmodule TextToBinary.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TextToBinaryWeb.Telemetry,
      # Start the Ecto repository
      TextToBinary.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TextToBinary.PubSub},
      # Start Finch
      {Finch, name: TextToBinary.Finch},
      # Start the Endpoint (http/https)
      TextToBinaryWeb.Endpoint
      # Start a worker by calling: TextToBinary.Worker.start_link(arg)
      # {TextToBinary.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TextToBinary.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TextToBinaryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
