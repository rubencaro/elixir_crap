defmodule MyProject do
	use Application

	def start(_type, _args) do
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
		IO.puts "hey2"

		"Running %{bright}MyProject%{reset} on %{green}http://localhost:4000%{reset}"
		|> IO.ANSI.escape |> IO.puts

		Plug.Adapters.Cowboy.http __MODULE__, []
  end

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end