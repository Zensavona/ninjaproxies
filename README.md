# Ninjaproxies

A (very) simple Elixir API client for [NinjaProxies](http://ninjaproxies.com)


## Installation

```
...
 def application do
  [applications: [:logger, :httpoison]]
end
...
defp deps do
  [{:ninjaproxies, "~> 0.1"}]
end
...
```

## Example usage

```
# your API key
iex(1)> Ninjaproxies.configure("XXXXXXXXXX")
:ok
# or
iex(2)> System.put_env("NINJAPROXIES_API_KEY", "XXXXXXXXXX")
iex(3)> Ninjaproxies.configure
:ok
# or
iex(4)> Application.put_env(:ninjaproxies, :api_key, "XXXXXX")
iex(5)> Ninjaproxies.configure
:ok

# let's get some proxies
iex(6)> Ninjaproxies.request(%{instagram: 1, order: "bandwidth_DESC", limit: 2, protocol: ["https", "http"], whitelisted: 1, alive: 1, regionName: "New_York"})           [%Ninjaproxies.Proxy{alive: "1", bandwidth: "312926", cityName: "New_York_City",
  connectTotal: "1", cookie: "0", countryCode: "US",
  countryName: "United_States", craigslist: "1", created: "2015-11-11 02:15:29",
  facebook: "1", get: "1", google: "1", id: "3161000", instagram: "1",
  ip: "XXX.XXX.XXX.XXX", modified: "2015-11-11 02:30:56", paypal: "1",
  pinterest: "1", portNum: "80", post: "1", processing: false, protocol: "http",
  referrer: "0", regionName: "New_York", speed: "0", twitter: "1",
  type: "Elite", uptime: "1", uptimeAverage: "100", whitelisted: true,
  youtube: "1"},
 %Ninjaproxies.Proxy{alive: "1", bandwidth: "302602", cityName: "Bethpage",
  connectTotal: "18", cookie: "0", countryCode: "US",
  countryName: "United_States", craigslist: "0", created: "2015-05-12 12:31:10",
  facebook: "1", get: "1", google: "1", id: "2687765", instagram: "1",
  ip: "XX.XX.XX.XX", modified: "2015-11-19 05:12:51", paypal: "1",
  pinterest: "1", portNum: "8080", post: "1", processing: false,
  protocol: "http", referrer: "0", regionName: "New_York", speed: "0",
  twitter: "1", type: "Elite", uptime: "3", uptimeAverage: "17",
  whitelisted: true, youtube: "1"}]
```

**Take a look at the NinjaProxies API docs or run `h Ninjaproxies.request` to see the full range of options passable.**