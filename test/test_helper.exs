defmodule TestHelpers.Assertions do
  import ExUnit.Assertions

  def assert_contains(collection, value) do
    assert Enum.member?(collection, value), "expected #{inspect(collection)} to contain #{inspect(value)}"
  end

  def assert_between(actual, lower_bound, upper_bound) do
    assert actual >= lower_bound && actual <= upper_bound, "expected #{inspect(actual)} to be between #{inspect(lower_bound)} and #{inspect(upper_bound)}"
  end

  def assert_is_struct(value, module) do
    assert is_map(value) && value.__struct__ == module, "expected #{module}, got #{inspect(value)}"
  end

  def get_metric_keys() do
    [_, _, metrics, _] = NewRelic.Collector.poll
    Map.keys(metrics)
  end
  def get_metric_by_key(key) do
    [_, _, metrics, _] = NewRelic.Collector.poll
    metrics[key]
  end
end

Application.put_env(:new_relic, :application_name, "Test")
Application.put_env(:new_relic, :license_key, "xyz")

ExUnit.start()
