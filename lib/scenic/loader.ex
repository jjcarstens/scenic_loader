defmodule Scenic.Loader do
  use Scenic.Component, has_children: false

  import Scenic.Primitives, only: [arc: 2, arc: 3]

  alias Scenic.Graph

  @default_phase_time 600
  @total_radians 6.283

  defdelegate stop(graph, id), to: Scenic.Loader.Component, as: :stop_loader

  @impl true
  def verify(data), do: {:ok, data}

  @impl true
  def init(_data, opts) do
    step = @total_radians / Keyword.get(opts, :phase_time, @default_phase_time)

    # Make sure we have the important defaults
    id = opts[:id] || :loader

    opts =
      opts
      |> Keyword.put(:id, id)
      |> Keyword.put_new(:stroke, {20, :blue})

    graph =
      Graph.build()
      |> arc({100, 0, step}, opts)

    state = %{graph: graph, step: step}

    Process.send_after(self(), :animate, 1)

    {:ok, state, push: state.graph}
  end

  @impl true
  def handle_info(:animate, state) do
    graph = Graph.modify(state.graph, :loader, &do_animate(&1, state.step))

    {:noreply, %{state | graph: graph}, push: graph}
  end

  defp do_animate(%{data: {size, start, val}} = loader, step)
       when start >= @total_radians and val >= @total_radians do
    # We've completed the arc, so start taking it back
    Process.send_after(self(), :animate, 100)
    arc(loader, {size, 0, step})
  end

  defp do_animate(%{data: {size, start, val}} = loader, step) when val < @total_radians do
    # Try to slow down the arc take-back...maybe?
    spin = val / step
    time = :math.pow(5, -spin)

    Process.send_after(self(), :animate, round(time))
    arc(loader, {size, start, val + step})
  end

  defp do_animate(%{data: {size, start, val}} = loader, step) do
    # Progress the arc
    Process.send_after(self(), :animate, 1)

    arc(loader, {size, start + step, val})
  end
end
