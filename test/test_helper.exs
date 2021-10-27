ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Chatter.Repo, :manual)

# Wallaby (BDD) Specific
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, ChatterWeb.Endpoint.url())
