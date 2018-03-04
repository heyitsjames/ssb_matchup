defmodule SsbMatchup.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :data, :map

      timestamps()
    end

  end
end
