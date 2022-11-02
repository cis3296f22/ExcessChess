class_name Piece
# Piece is the base class for chess engine pieces.

enum Team { WHITE, BLACK }
enum Type { PAWN, ROOK, KNIGHT, BISHOP, QUEEN, KING }

# Properties
var team = -1
var type = -1
var hasMoved = false


# Given board state information, this function returns a list of potentially valid new positions.
func getMoves(_state):
	pass
