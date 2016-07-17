# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :shlack, Shlack.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "fFH/xGf6AUC7B2jbhSoqtASqMCgw0hsTqjd+IZDfby/2U9bcWit951Ura3lM3jAH",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Shlack.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false


config :guardian, Guardian,
  issuer: "Shlack.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Shlack.GuardianSerializer,
  secret_key: to_string(Mix.env),
  hooks: GuardianDb,
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
      ],
    }

config :guardian_db, GuardianDb,
  repo: Shlack.Repo
