defmodule Store.Shopping do
  use Application
  import Supervisor.Spec, warn: false

  # entry point to start our app
  def start(_type, _args) do
    # supervision goes here. This defines a worker,
    # a thing which will be supervised. That thing to be
    # supervised is our app. This is a spec,
    # not actually starting up the process.
    start_session_supervisor
  end

  # where is our parent supervisor?
  def start_session_supervisor do
    # spec the session supervisor
    session_worker = worker(Store.Shopping.Session, [])
    Supervisor.start_link(
      [session_worker],
      # 1-1 means "if the worker dies, start a new one",
      # i.e. replacement population controls
      strategy: :simple_one_for_one,
      name: Store.SessionSupervisor
    )
  end

  def start_session(key: key) when is_binary(key) do
    raise "please use an atom key"
  end

  def start_session(key: key) when is_atom(key) do
    res = Supervisor.start_child(
      Store.SessionSupervisor,
      [%{key: key}]
    )
  end
end
