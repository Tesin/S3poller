defmodule S3pollerTest do
  use ExUnit.Case
  doctest S3poller

  test "greets the world" do
    assert S3poller.hello() == :world
  end
end
