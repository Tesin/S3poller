defmodule S3poller do

  alias ExAws.S3

  def retrieve_objects() do
    { :ok, %{ body: %{ contents: contents } } } =
      S3.list_objects("clockwork-data-science")
      |> ExAws.request

      contents
  end

  def build_initial_list() do
    response = retrieve_objects()

    initialList = Enum.map( response, fn( %{ key: key, last_modified: last_modified } ) ->
      [key: key, last_modified: last_modified]
    end )

    initialList
  end

  def poll_for_changes do
    response = retrieve_objects()

    response
  end



end
