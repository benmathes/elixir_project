defmodule Standard.PageController do
  use Standard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
