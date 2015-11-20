defmodule Ninjaproxies do
  @moduledoc """
  A very simple interface for programatically dealing with the [NinjaProxies](http://ninjaproxies.com) API
  """

  @doc """
  Set the API key for making requests

  ## Example
    iex(1)> Ninjaproxies.configure("XXXXXXXXXXX")
    :ok
  """
  defdelegate configure(api_key), to: Ninjaproxies.Config, as: :configure

  @doc """
  Set the API key from the application config or ENV var
  """
  defdelegate configure, to: Ninjaproxies.Config, as: :configure

  @doc """
  Request a list of proxies

  - limit is an integer
  - options is a map with the following potential members, each a single string or list of strings: :order, :portNum, :type, :prototol, :countryCode, :countryName, :regionName, :speed, :bandwidth, :uptime, :whitelisted, :referrer, :cookie, :get, :post, :google, :facebook, :paypal, :craigslist, :twitter, :youtube, :pinterest, :instagram, :alive, :limit
  """
  defdelegate request(options), to: Ninjaproxies.API, as: :request
end
