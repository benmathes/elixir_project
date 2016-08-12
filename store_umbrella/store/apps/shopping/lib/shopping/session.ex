defmodule Store.Shopping.Session do
  use GenServer
  alias Redfour.Shopping.DB

  defstruct [
    store_id: nil,
    id: nil,
    key: nil,
    landing: "/",
    ip: "127.0.0.1",
    member_id: nil,
    items: [],
    logs: [%{entry: "session created"}],
    discounts: []
  ]

  # wrap the GenServer functionality
  def start_link(%{key: key} = args) do
    GenServer.start_link(__MODULE__, args)
  end

  # init function, which is called automatically by GenServer
  # right after start_link, w/ initial args passed to init.
  # the result of init is what is stored as "state" (GenServer
  # actually uses accumulators, since FP is all about immutability)
  def init(%{key: key} = args) do
    struct(%Redfour.Shopping.Session{}, args)
  end
  

  # public API, wrapping calls to GenServer so the internals of
  # our store Session (the internals are the GenServer) doesn't leak.
  def select_item(pid, item) do
    GenServer.call(pid, {:select_item, item})
  end

  def remove_item(pid, sku: sku) do
    GenServer.call(pid, {:remove_item, sku: sku})
  end

  def change_item(pid, sku: sku) do
    GenServer.call(pid, {:change_item, sku: sku})
  end


  # internal GenServer implementation of GenServer methods that
  # we wrapped in the public API
  def handle_call({:select_item, item}, _sender, session) do
    # take the current session and add the new item
    # to the :items key at the end (index -1)
    session = %{session | items: List.insert_at(session.items, -1, item)}

    # This is an "ok" response, in bad situations we could
    # return with {:noreply, session}, or {:stop, reason, [reply], state}, etc.
    # but this whole project is an exercise in architecture,
    # so error-checking is not a priority
    {:reply, session, session}
  end
  def handle_call({:remove_item, sku: sku}, _sender, session) do

  end
  def handle_call({:change_item, sku: sku}, _sender, session) do

  end

  
  # private
  def save_session(%Store.Shopping.Session{} = session, log: log) do
    %{session | logs: List.insert_at(session.logs, -1, %{entry: log})} |> DB.save_session
  end
  

end
