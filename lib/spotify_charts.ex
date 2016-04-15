defmodule SpotifyCharts do
  @spotify "https://spotifycharts.com/api/?type=regional&country=global&recurrence=daily&date=latest"

  def get_charts do
    # make raw request
    get_body(HTTPoison.get(@spotify))
    |> parse_json
    |> get_items
    |> print_items
    |> IO.inspect
  end

  defp get_body({:ok, %{body: body}}), do: body
  defp get_body(_), do: "[]"

  # parse JSON
  defp parse_json(body), do: Poison.decode!(body)
  defp get_items(%{"entries" => %{"items" => items}}), do: items
  defp get_items(_), do: :error
  defp print_items(items) do
    Enum.each(items, fn item ->
      print_item(item)
    end)
  end
  defp print_item(item), do: IO.puts "#{item["current_position"]}"


end
