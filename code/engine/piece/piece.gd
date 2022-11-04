class_name Piece
# Piece is the base class for chess pieces.


# Built-in chess teams.
const Team = {
    WHITE = "white",
    BLACK = "black",
}
# Built-in chess piece types.
const Type = {
    PAWN = "pawn",
    KNIGHT = "knight",
    BISHOP = "bishop",
    ROOK = "rook",
    QUEEN = "queen",
    KING = "king",
}
var team
var type
var id
var has_moved


func _init(team_new, id_new):
    team = team_new
    id = id_new
    has_moved = false


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# orig_pos: The original postion of the piece.
# max_pos: The maximum board position.
# board_width: The length of the board's width.
# board_map: The map of board positions and chess pieces.
# prev_move: Information about the previous chess movement.
func calc_moves(_orig_pos, _max_pos, _board_width, _board_map, _prev_move):
    pass
