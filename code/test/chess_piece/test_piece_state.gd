extends GutTest
# Tests the piece state management methods.
const PieceState = preload("res://engine/piece/piece_state.gd")
const CustomPiece = preload("res://engine/piece/custom_piece.gd")

var piece_state
var piece_logic

# A test-purpose inner class that meets the minimum requirement of a chess piece.
class CustomPieceTest extends CustomPiece:

	var name = "custom_piece"


func before_each():
	# Reset the piece state.
	piece_logic= CustomPieceTest.new()
	piece_state = PieceState.new("0", "test", piece_logic)


# Tests that the piece type can be changed.
func test_change_type():
	# Create a new custom piece type.
	var new_type = CustomPieceTest.new()
	new_type.set("name", "new_piece")

	piece_state.change_type(new_type)

	assert_eq(piece_state.type.name, "new_piece", "Piece should be named new_piece.")
