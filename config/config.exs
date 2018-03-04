# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ssb_matchup,
  ecto_repos: [SsbMatchup.Repo]

# Configures the endpoint
config :ssb_matchup, SsbMatchupWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+plHr8rdIQh/TseXdIxuybMVZT6Ju6QuNOI9Ne/Om/qKbneDZZd/xw7l7EWuGCTE",
  render_errors: [view: SsbMatchupWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SsbMatchup.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
