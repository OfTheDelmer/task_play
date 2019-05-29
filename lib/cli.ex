defmodule TaskPlay.CLI do
  def main(args) do
    IO.puts "running!"
    run_command(args)
  end

  def run_command(["wow!"]) do
    IO.puts "tres wows!"
  end

  def run_command(["simple"]) do
    IO.puts "simple start..."
    # GenServer.start_link(TaskPlay.Simple, [:start])
    TaskPlay.Simple.start_link()
    GenServer.call(TaskPlay.Simple, :start, :infinity)
  end
end
