defmodule JsonSchema do
  @moduledoc """
  Documentation for `JsonSchema`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> JsonSchema.hello()
      :world

  """
  def validate do
    files = [
      "text_request",
      "text_response"
    ]

    schemas = files
    |> Map.new(fn f ->
      data = "lib/#{f}.json"
        |> File.read!
        |> Jason.decode!

      schema = JsonXema.new(data)

      {f, schema}
    end)
    # |> IO.inspect

    # Now we test it out - Request
    schema = schemas["text_request"]
    IO.inspect JsonXema.validate!(schema, valid_request())

    # Now we test it out - Request
    schema = schemas["text_response"]
    IO.inspect JsonXema.validate!(schema, valid_response())



    # Now we test it out - Request
    schema = schemas["text_response"]
    IO.inspect JsonXema.validate(schema, valid_request())

    # Now we test it out - Request
    schema = schemas["text_request"]
    IO.inspect JsonXema.validate(schema, valid_response())
  end

  defp valid_request do
    """
    {
      "command": "account/getThing/request",
      "data": {
        "thingId": "blahblah"
      }
    }
    """
    |> Jason.decode!
  end

  defp valid_response do
    """
    {
      "command": "account/getThing/response",
      "data": {
        "thing": {
          "name": "bob",
          "age": 20
            }
          }
      }
    """
    |> Jason.decode!
  end
end
