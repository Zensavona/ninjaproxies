defmodule Ninjaproxies.Config do

  @doc """
  Set an API key to be used with all requests
  """
  def configure(api_key) do
    start_link(%{api_key: api_key})
    :ok
  end

  @doc """
  Set the API key from the app config or ENV var
  """
  def configure do
    cond do
      !is_nil(Application.get_env(:ninjaproxies, :api_key)) ->
        start_link(%{api_key: Application.get_env(:ninjaproxies, :api_key)})
        :ok
      !is_nil(System.get_env("NINJAPROXIES_API_KEY")) ->
        start_link(%{api_key: System.get_env("NINJAPROXIES_API_KEY")})
        :ok
      true ->
        :not_found
    end
  end

  @doc """
  Get the configuration object
  """
  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  defp set(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
