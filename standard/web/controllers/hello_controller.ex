defmodule Standard.HelloController do
  use Standard.Web, :controller

  def index(connection, _params) do
    render connection, "index.html"
  end
end
