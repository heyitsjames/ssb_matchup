defmodule SsbMatchupWeb.BoardControllerTest do
  use SsbMatchupWeb.ConnCase

  alias SsbMatchup.MatchupBoards
  alias SsbMatchup.MatchupBoards.Board

  @create_attrs %{data: %{}}
  @update_attrs %{data: %{}}
  @invalid_attrs %{data: nil}

  def fixture(:board) do
    {:ok, board} = MatchupBoards.create_board(@create_attrs)
    board
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all boards", %{conn: conn} do
      conn = get conn, board_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create board" do
    test "renders board when data is valid", %{conn: conn} do
      conn = post conn, board_path(conn, :create), board: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, board_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "data" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, board_path(conn, :create), board: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update board" do
    setup [:create_board]

    test "renders board when data is valid", %{conn: conn, board: %Board{id: id} = board} do
      conn = put conn, board_path(conn, :update, board), board: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, board_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "data" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn, board: board} do
      conn = put conn, board_path(conn, :update, board), board: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete board" do
    setup [:create_board]

    test "deletes chosen board", %{conn: conn, board: board} do
      conn = delete conn, board_path(conn, :delete, board)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, board_path(conn, :show, board)
      end
    end
  end

  defp create_board(_) do
    board = fixture(:board)
    {:ok, board: board}
  end
end
