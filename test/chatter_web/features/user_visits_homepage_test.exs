defmodule ChatterWeb.UserVistsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit homepage", %{session: session} do
    user =
      build(:user)
      |> set_password("superpass")
      |> insert()

    session
    |> visit("/")
    |> sign_in(as: user)
    |> assert_has(page_heading("Welcome to Chatter!"))
  end

  defp page_heading(string) do
    Query.data("role", "title", text: string)
  end
end
