defmodule Mix.Tasks.Hello do
  use Mix.Task

  @shortdoc "Starts the S3poller service"
  def run(_) do
    S3poller.run
  end
end
