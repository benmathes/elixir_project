defmodule Store.Shopping.DB do
  use Moebious.Database
  import Moebious.DocumentQuery
  alias Store.Shopping.DB

  # ||init session
  def find_or_create_session(%{key: key, domain: domain} = args) do
    case db(:sessions) |> contains(key: key) |> DB.first do
      nil -> db(:sessions) |> DB.save(struct(%Store.SHopping.Session{}, args))
      found -> found
    end
  end

  def save_session(session) do
    db(:sessions) |> DB.save(session)
  end
end
