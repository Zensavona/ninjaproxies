defmodule Ninjaproxies.Proxy do
  defstruct [:alive, :bandwidth, :cityName, :connectTotal, :cookie, :countryCode, :countryName, :craigslist, :created, :facebook, :get, :google, :id, :instagram, :ip, :modified, :paypal, :pinterest, :portNum, :post, :processing, :protocol, :referrer, :regionName, :speed, :twitter, :type, :uptime, :uptimeAverage, :whitelisted, :youtube]
end

defmodule Ninjaproxies.API do
  @moduledoc """
  Internal module to fetch data from the API
  """
  @base "http://ninjaproxies.com/proxies/api/"
  @options ~w(order portNum type protocol countryCode countryName regionName speed bandwidth uptime whitelisted referrer cookie get post google facebook paypal craigslist twitter youtube pinterest instagram alive limit key)a

  @doc """
  request some results from the HTTP API
  """
  def request(options \\ %{}) do
    api_key = Ninjaproxies.Config.get.api_key
    options = options |> Map.put(:key, api_key) |> build_options
    case HTTPoison.get(@base <> options, [], [follow_redirect: true, timeout: 60000, recv_timeout: 60000]) do
      {:ok, %{status_code: 200} = response} ->
        Poison.decode!(response.body, keys: :atoms).data |> Enum.map(&parse_proxy/1)
      {:ok, %{status_code: code, body: body}} ->
        message = body |> Poison.decode! |> Map.get("data")
        raise(Ninjaproxies.APIError, [code: code, message: message])
    end
  end

  defp build_options(options) do
    options = Enum.filter(options, fn({k, v}) -> Enum.member?(@options, k) end)
    options |> Enum.reduce("?", fn(opt, acc) -> acc <> build_option(opt) <> "&" end)
  end
  defp build_option({key, values}) when is_list(values) do
    opts = Enum.reduce(values, fn(v, acc) -> acc <> "+" <> v end)
    to_string(key) <> "=" <> opts
  end
  defp build_option({key, value}) when is_binary(value) do
    to_string(key) <> "=" <> value
  end
  defp build_option({key, value}) do
    to_string(key) <> "=" <> to_string(value)
  end

  defp parse_proxy(proxy) do
    proxy = Map.get(proxy, :Proxy)
    struct(Ninjaproxies.Proxy, proxy)
  end
end