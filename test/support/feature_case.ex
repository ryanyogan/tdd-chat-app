defmodule ChatterWeb.FeatureCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL
      import Chatter.Factory
      alias ChatterWeb.Router.Helpers, as: Routes

      @endpoint ChatterWeb.Endpoint
    end
  end

  setup tags do
    pid =
      Ecto.Adapters.SQL.Sandbox.start_owner!(
        Chatter.Repo,
        shared: not tags[:async]
      )

    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Chatter.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session, metadata: metadata}
  end
end
