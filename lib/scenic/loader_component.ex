defmodule Scenic.Loader.Component do
  alias Scenic.{Loader, Graph, Primitive}

  @moduledoc """
  A helper to add a loading spinner to a scene
  """

  @doc """
  Add a loading spinner to your graph
  """
  def loader(graph_or_primitive, options \\ [])

  def loader(%Graph{} = g, options) do
    add_to_graph(g, Loader, nil, options)
  end

  def loader(%Primitive{module: Primitive.SceneRef} = p, options) do
    modify(p, Loader, nil, options)
  end

  @doc """
  Stops (removes) the loader from graph.
  """
  def stop_loader(%Graph{} = g, id \\ :loader) do
    Graph.delete(g, id)
  end

  @doc """
  See loader/2
  """
  def loader_spec(options), do: &loader(&1, options)

  defp add_to_graph(%Graph{} = g, mod, data, options) do
    mod.verify!(data)
    mod.add_to_graph(g, data, options)
  end

  defp modify(%Primitive{module: Primitive.SceneRef} = p, mod, data, options) do
    mod.verify!(data)
    Primitive.put(p, {mod, data}, options)
  end
end
