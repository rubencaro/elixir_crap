defmodule MyProject do
  use Application

  def start(_type, _args) do
    
    :emysql.add_pool(:db, [ size: 50, user: 'root', password: 'dbPASS', database: 'test_elixur', encoding: :utf8 ])

    import Supervisor.Spec, warn: false

    children = [ worker(MyProject.Plug, []) ]

    opts = [strategy: :one_for_one, name: MyProject.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule MyProject.Plug do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link() do
    ["Running ", :bright, "MyProject", :reset, " on ", :green, "http://localhost:4000", :reset]
    |> IO.ANSI.format(true) |> IO.puts

    Plug.Adapters.Cowboy.http __MODULE__, []
  end

  get "/hello" do
    result = :emysql.execute :db, "select sleep(2)" 
    IO.puts( inspect result )
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
