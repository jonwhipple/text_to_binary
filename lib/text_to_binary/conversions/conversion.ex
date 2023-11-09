defmodule TextToBinary.Conversions.Conversion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversions" do
    field :input_text, :string
    field :output_binary, :string
    # field :markdown, :string

    timestamps()
  end

  def text_to_utf8_binary(text) do
    text
    |> String.graphemes()
    |> Enum.flat_map(&String.to_charlist(&1))
    |> Enum.map(&code_point_to_binary/1)
    |> Enum.join(" ")
  end

  defp code_point_to_binary(code_point) do
    binary_representation = Integer.to_string(code_point, 2)

    case code_point do
      _ when code_point in 0..127 -> String.pad_leading(binary_representation, 8, "0")
      _ when code_point in 128..2047 -> String.pad_leading(binary_representation, 16, "0")
      _ when code_point in 2048..65535 -> String.pad_leading(binary_representation, 24, "0")
      _ -> String.pad_leading(binary_representation, 32, "0")
    end
  end

  # def to_markdown(binary_string) do
  #   "```:robot_face: " <> binary_string <> " ```"
  # end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(conversion, attrs) do
    conversion
    |> cast(attrs, [:input_text, :output_binary])
    |> validate_required([:input_text, :output_binary])
  end
end
