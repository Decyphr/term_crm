defmodule TermCrmWeb.PageController do
  use TermCrmWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
