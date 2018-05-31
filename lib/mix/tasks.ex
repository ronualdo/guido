defmodule Mix.Tasks do
  use Mix.Task

  @preferred_cli_env :test

  @shortdoc "runs unit tests for the project"
  defmodule UnitTest do
    def run(_) do
      Mix.Task.run("test", ["--exclude", "acceptance", "--exclude", "integration"])
    end
  end

  @shortdoc "runs acceptance tests for the project"
  defmodule AcceptanceTest do
    def run(_) do
      Mix.Task.run("test", ["--only", "acceptance"])
    end
  end

  @shortdock "run integration tests"
  defmodule IntegrationTest do
    def run(_) do
      Mix.Task.run("test", ["--only", "integration"])
    end
  end
end
