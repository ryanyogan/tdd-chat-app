defmodule ChatterWeb.UserVistsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(page_heading("Welcome to Chatter!"))
  end

  defp page_heading(string) do
    Query.data("role", "title", text: string)
  end
end
