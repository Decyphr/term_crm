defmodule TermCrmWeb.PageControllerTest do
  use TermCrmWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")

    # Ensure the page contains the app name or some unique text to confirm it's rendering correctly
    assert html_response(conn, 200) =~ "termcrm"
  end
end
