defmodule GuidoWeb.PageControllerTest do
  use GuidoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "GET /movies", %{conn: conn} do
    conn = get conn, "/api/movies"

    assert json_response(conn, 200) == []
  end
end
