defmodule PingPong do
  def ping do
    receive do
      {from, :ping} ->
        IO.puts 'ping'
        :timer.sleep(1000)
        send from, {self(), :pong}
    end
    ping
  end

  def pong do #1
    receive do
      {from, :pong} -> #2
        IO.puts 'pong'
        :timer.sleep(1000) #4
        send from, {self(), :ping} #3
    end
    pong
  end

  def start do
    ping_pid = spawn __MODULE__, :ping, []
    pong_pid = spawn __MODULE__, :pong, [] #5
    send ping_pid, {pong_pid, :ping}
  end
end
