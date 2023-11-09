defmodule TextToBinary.Repo.Migrations.CreateConversions do
  use Ecto.Migration

  def change do
    create table(:conversions) do
      add :input_text, :text
      add :output_binary, :text

      timestamps()
    end
  end
end
