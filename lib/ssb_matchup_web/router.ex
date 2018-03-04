defmodule SsbMatchupWeb.Router do
  use SsbMatchupWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SsbMatchupWeb do
    pipe_through :api
    resources "/boards", BoardController
  end
end
