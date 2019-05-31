defmodule TaskPlay.CLI do
  alias __MODULE__

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


  def run_command(["job"]) do
    TaskPlay.RecurJob.start(%{
      every: 1_000,
      task: CLI.HelloTask
    })

    Process.sleep(10_000)
  end

  defmodule HelloTask do

    def execute() do
      IO.puts "Hello world"
    end
  end
end
