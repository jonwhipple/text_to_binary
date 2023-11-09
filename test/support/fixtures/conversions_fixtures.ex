defmodule TextToBinary.ConversionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TextToBinary.Conversions` context.
  """

  @doc """
  Generate a conversion.
  """
  def conversion_fixture(attrs \\ %{}) do
    {:ok, conversion} =
      attrs
      |> Enum.into(%{
        input_text: "some input_text",
        output_binary: "some output_binary"
      })
      |> TextToBinary.Conversions.create_conversion()

    conversion
  end
end
