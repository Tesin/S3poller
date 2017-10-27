defmodule S3pollerTest do
  use ExUnit.Case

  test "Build initial list" do
    response = S3poller.build_initial_list
    assert [ [key: _key, last_modified: _last_modified ], _ ] = response
  end
  
end
