defmodule TaskPlay.Simple do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(simple) do
    do_work()
    {:ok, simple}
  end

  def handle_call(:start, _from, _state) do
    self() |> Process.send_after(:loop, :timer.seconds(2))
    IO.puts "VROOOOOOOM!"
    {:noreply, nil}
  end

  def handle_info(:loop, msg) do
    IO.inspect msg
    self() |> Process.send_after(:loop, :timer.seconds(2))
    IO.puts "info loop!!!"
    {:noreply, nil}
  end

  defp do_work() do
    IO.puts "working..."
  end
end
