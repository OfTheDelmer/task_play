defmodule TaskPlay.RecurJob do
  use GenServer
  alias __MODULE__


  def start(config) do
    IO.puts "HELLO "
    GenServer.start(__MODULE__, config)
  end

  def init(config) do
    every = Map.get(config, :every, 1_000)
    scheduler = Map.get(config, :scheduler, RecurJob.Repeat)

    schedule = scheduler.new(%{
      pid: self(),
      every: every,
      message: :recur
    })

    config = %{
      job: %{
        schedule: schedule,
        task: Map.fetch!(config, :task),
      }
    }

    scheduler.start(schedule)

    {:ok, config}
  end

  def handle_cast({:recur}, config) do
    IO.puts "INFO"
    config.job.task.execute()
    {:noreply, config}
  end

  defmodule Repeat do
    defstruct [:pid, :every, :message]

    def new(%{
      pid: pid,
      message: message,
      every: every
    }) do
      %__MODULE__{
        pid: pid,
        message: message,
        every: every
      }
    end

    def start(repeat) do
       Task.start_link(fn ->
        loop(repeat)
      end)
    end


    def loop(repeat) do
      Process.send_after(repeat.pid, repeat.message, repeat.every)
      # receive do
      # after
      #   repeat.every ->
      #     GenServer.cast(repeat.pid, {repeat.message})
      #     loop(repeat)
      # end
    end
  end
end
