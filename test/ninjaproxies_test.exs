defmodule NinjaproxiesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Ninjaproxies

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "set config from input" do
    assert :ok = Ninjaproxies.configure("XXXXXXXXXXXX")
    assert "XXXXXXXXXXXX" = Ninjaproxies.Config.get.api_key
  end

  test "set config from ENV config" do
    System.put_env("NINJAPROXIES_API_KEY", "XXXXXXXXXX")
    assert :ok = Ninjaproxies.configure
    assert "XXXXXXXXXX" = Ninjaproxies.Config.get.api_key
  end

  test "set config from application config" do
    Application.put_env(:ninjaproxies, :api_key, "XXXXXX")
    assert :ok = Ninjaproxies.configure
    assert "XXXXXX" = Ninjaproxies.Config.get.api_key
  end

  test "request some proxies" do
    assert :ok = Ninjaproxies.configure("XXXXXXXXXX")

    use_cassette "request_proxies" do
      proxies = Ninjaproxies.request(%{instagram: "1", order: "bandwidth_DESC", limit: 2, protocol: ["https", "http"], whitelisted: "1", alive: "1", regionName: "New_York"})
      assert length(proxies) == 2
      Enum.each(proxies, fn(p) ->
        assert p.regionName == "New_York"
      end)
    end
  end

  test "request some proxies and throw an error" do
    assert :ok = Ninjaproxies.configure("XXXXXXXX")

    use_cassette "request_proxies_error" do
      assert_raise Ninjaproxies.APIError, fn ->
        Ninjaproxies.request(%{get: 1, post: 1, limit: 2})
      end
    end
  end
end
