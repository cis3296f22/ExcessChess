extends GutTest
# Tests the game state management methods.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const CustomPiece = preload("res://engine/piece/custom_piece.gd")

var game_state
var piece_state
var piece_logic

# A test-purpose inner class that meets the minimum requirement of a chess piece.
class CustomPieceTest extends CustomPiece:

	var name = "custom_piece"


func before_each():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Create a piece.
	piece_logic = CustomPieceTest.new()
	piece_state = PieceState.new(42, "team", piece_logic)


# Tests the retrieval of a piece from coordinates.
func test_state_from_cord_pass():
	# Directly add a piece to the board to position 18 (c6).
	game_state.pieces_state.append(piece_state)
	game_state.pieces_cord.append(18)

	assert_eq(game_state.state_from_cord(18).id, 42, "Piece id number should be 42.")


# Tests that retrival of a non-existent piece from coordinates fails.
func test_state_from_cord_fail():
	assert_null(game_state.state_from_cord(45), "A piece should not exist at 45 (f3)")


# Tests that a piece's index number, not id number, can be retrieved from its coordinate.
func test_index_from_cord_pass():
	# Directly add a piece to the board to position 18 (c6).
	game_state.pieces_state.append(piece_state)
	game_state.pieces_cord.append(18)

	assert_eq(game_state.index_from_cord(18), 0, "The piece should be at index 0.")


# Tests that an index number cannot be found if there is no piece at a coordinate.
func test_index_from_cord_fail():
	assert_eq(game_state.index_from_cord(18), null, "A piece should not exist at position 18 (c6).")


# Tests that a game state can be copied.
func test_copy():
	# TODO Test deep game state copy.
	pending()


# Tests the addition of a chess piece.
func test_add():
	# Adds a piece to position 18 (c6).
	game_state.add(piece_state, 18)

	assert_eq(game_state.pieces_state.size(), 1, "The number of pieces should be 1.")
	assert_eq(game_state.pieces_cord[0], 18, "The piece should be at position 18 (c6).")


# Tests that the game state can identify if a piece exists at a location.
func test_has():
	# Directly add a piece to the board to position 18 (c6).
	game_state.pieces_state.append(piece_state)
	game_state.pieces_cord.append(18)

	assert_true(game_state.has(18), "The piece should exist at position 18 (c6).")
	assert_false(game_state.has(19), "A piece should not exist at position 19 (d7).")

# Tests that a piece at a coordinate has a specific type.
func test_has_specific_type():
	# Create another piece to test against.
	var test_logic = CustomPieceTest.new()
	var test_state = PieceState.new(0, "team", test_logic)

	# Directly add a piece to the board to position 18 (c6).
	game_state.pieces_state.append(piece_state)
	game_state.pieces_cord.append(18)

	# Test if the piece's type matches the original logic type.
	assert_true(game_state.has_specific_type(18, piece_state), "Type should match.")

	# Test if the piece's type does not match the new logic type.
	assert_false(game_state.has_specific_type(18, test_state), "Type should not match.")

# Tests that a piece can be removed by its index number.
func test_remove():
	# Directly add a piece to the board to position 18 (c6).
	game_state.pieces_state.append(piece_state)
	game_state.pieces_cord.append(18)

	game_state.remove(0)

	assert_eq(game_state.pieces_cord.size(), 0, "List of piece coordinates should be empty.")
	assert_eq(game_state.pieces_state.size(), 0, "List of piece states should be empty.")


# Tests that a piece can be moved from one coordinate to another.
	# Directly add a piece to the board to position 18 (c6).
	game_state.pieces_state.append(piece_state)
	game_state.pieces_cord.append(18)

	# Move the piece from 18 (c6) to 45 (f3)
	game_state.move(18, 45)

	assert_eq(game_state.pieces_cord[0], 45, "The piece should exist at position 45 (f3).")

# Tests an en passant move.
func test_passeant_move():
	pending()