class_name Piece
# Piece is the base class for chess engine pieces.

enum Team { WHITE, BLACK }
enum Type { PAWN, ROOK, KNIGHT, BISHOP, QUEEN, KING }

# Properties
var team = -1
var type = -1
var has_moved = false


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# orig_pos: The original postion of the piece.
# max_pos: The maximum board position.
# board_width: The length of the board's width.
# board_map: The map of board positions and chess pieces.
# prev_move: Information about the previous chess movement.
func calc_moves(_orig_pos, _max_pos, _board_width, _board_map, _prev_move):
	pass
