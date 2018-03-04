defmodule SsbMatchupWeb.BoardController do
  use SsbMatchupWeb, :controller

  alias SsbMatchup.MatchupBoards
  alias SsbMatchup.MatchupBoards.Board

  action_fallback SsbMatchupWeb.FallbackController

  def index(conn, _params) do
    boards = MatchupBoards.list_boards()
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    with {:ok, %Board{} = board} <- MatchupBoards.create_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", board_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def show(conn, %{"id" => id}) do
    board = MatchupBoards.get_board!(id)
    render(conn, "show.json", board: board)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = MatchupBoards.get_board!(id)

    with {:ok, %Board{} = board} <- MatchupBoards.update_board(board, board_params) do
      render(conn, "show.json", board: board)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = MatchupBoards.get_board!(id)
    with {:ok, %Board{}} <- MatchupBoards.delete_board(board) do
      send_resp(conn, :no_content, "")
    end
  end
end
