defmodule TextToBinary.Repo.Migrations.AddMarkdownToConversions do
  use Ecto.Migration

  def change do
    alter table(:conversions) do
      add :markdown, :string
    end
  end
end
