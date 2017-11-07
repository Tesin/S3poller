defmodule S3poller do

  alias ExAws.S3

  def start_agents do
    Agent.start_link( fn -> build_initial_list() end, name: Current_state )
    Agent.start_link( fn -> [[]] end, name: S3_placeholder )
  end


  def build_initial_list() do
    response = retrieve_objects()

    initial_list = Enum.map( response, &extract_item/1 )
    initial_list
  end

  def extract_item( item ) do
    %{ key: key, last_modified: last_modified } = item
    [ key: key, last_modified: last_modified ]
  end


  def retrieve_objects() do
    { :ok, %{ body: %{ contents: contents } } } =
      S3.list_objects( System.get_env( "S3_BUCKET" ) )
      |> ExAws.request

      contents
  end


  def check_for_changes do
    current_s3_state = retrieve_objects()
    current_s3_keys  = Enum.map( current_s3_state, &extract_item/1 )

    current_agent_keys = Agent.get( Current_state, &(&1))

    s3_map    = MapSet.new( current_s3_keys )
    agent_map = MapSet.new( current_agent_keys )

    Agent.update( S3_placeholder, fn( _state ) ->
      current_s3_keys
    end )

    Agent.update( Current_state, fn( _state ) ->
      current_s3_keys
    end )

    MapSet.difference( s3_map, agent_map )
  end


  def poll do
    diff = check_for_changes()

    IO.inspect diff
    :timer.sleep( 10000 )

    poll()
  end


  def run do
    start_agents()

    poll()
  end
end
