defmodule SsbMatchup.MatchupBoards.Board do
  use Ecto.Schema
  import Ecto.Changeset


  schema "boards" do
    field :data, :map

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:data])
    |> validate_json_format()
    |> validate_required([:data])
  end

  defp validate_json_format(changeset) do
    data = get_change(changeset, :data)

  end
end
