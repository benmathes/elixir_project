# A Web  Store, with OTP approach

* install `phoenix` and `elixir` (I like homebrew)
* The OTP-based store: (based on http://rob.conery.io/2016/02/11/red-4-store-part-2/)
* in `/store_umbrella/store/` run `iex -S mix`
* in `iex` (interactive elixir), run:
** `Store.Shopping.start_session key: :foo`
** `Store.Shopping.start_session key: :bar`
** `Store.Shopping.start_session key: :baz`
** to test the `simple_one_for_one` startegy, kill one:
** `Process.whereis(:foo) != Process.exit(Process.whereis(:foo), :kill)`

