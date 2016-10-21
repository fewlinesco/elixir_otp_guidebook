defmodule Cache do
  use GenServer

  @name CH

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: CH])
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def write(key, value) do
    GenServer.call(@name, {:write, key, value})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def delete(key) do
    GenServer.call(@name, {:delete, key})
  end

  def clear do
    GenServer.cast(@name , :clear)
  end

  def exist?(key) do
    GenServer.call(@name, {:exist, key})
  end

  def handle_cast(:clear, _collection) do
    {:noreply, %{}}
  end

  def handle_call({:exist, key}, _from, collection) do
    {:reply, Map.has_key?(collection, key), collection}
  end
  def handle_call({:write, key, value}, _from, collection) do
    new_collection =
      case Map.has_key?(collection, key) do
        true ->
          Map.update!(collection, key, &(&1 = value))
        false ->
          Map.put_new(collection, key, value)
      end
    {:reply, new_collection, new_collection}
  end
  def handle_call({:read, key}, _from, collection) do
    case Map.has_key?(collection, key) do
      true ->
        {:reply, collection[key], collection}
      false ->
        {:reply, "Key not found !", collection}
    end
  end
  def handle_call({:delete, key}, _from, collection) do
    new_collection = Map.delete(collection, key)
    {:reply, new_collection, new_collection}
  end
end
