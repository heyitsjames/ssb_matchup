defmodule SsbMatchup.MatchupBoardsTest do
  use SsbMatchup.DataCase

  alias SsbMatchup.MatchupBoards

  describe "boards" do
    alias SsbMatchup.MatchupBoards.Board

    @valid_attrs %{data: %{}}
    @update_attrs %{data: %{}}
    @invalid_attrs %{data: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MatchupBoards.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert MatchupBoards.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert MatchupBoards.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = MatchupBoards.create_board(@valid_attrs)
      assert board.data == %{}
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MatchupBoards.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, board} = MatchupBoards.update_board(board, @update_attrs)
      assert %Board{} = board
      assert board.data == %{}
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = MatchupBoards.update_board(board, @invalid_attrs)
      assert board == MatchupBoards.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = MatchupBoards.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> MatchupBoards.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = MatchupBoards.change_board(board)
    end
  end
end
