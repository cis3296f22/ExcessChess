extends GutTest
# Tests the custom piece methods.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const CustomPiece = preload("res://engine/piece/custom_piece.gd")


var piece_logic
var custom_move


# A test-purpose inner class with the minimum requirements of a Move.
class CustomMoveTestPass:
	var name = "custom_move"
	func add_pos(_positions, _pos, _piece, _game):
		pass

# A test-purpose inner class that does not meet the requirements of a Move.
class CustomMoveTestFail extends Object:
	pass

# A test-purpose inner class that meets the minimum requirement of a chess piece.
class CustomPieceTest extends CustomPiece:
	var name = "custom_piece"


func before_all():
	# Create a custom move with the minimum requirements.
	custom_move = CustomMoveTestPass.new()


func before_each():
	# Load a custom piece logic without any moves.
	piece_logic = CustomPieceTest.new()


# Tests the move calculation call.
func test_calc_moves():
	# Setup
	# Create a standard 8x8 chess board.
	var game = GameState.new(8, 8)
	# Create a piece.
	var piece = PieceState.new(0, "test_team", piece_logic)
	var result

	result = piece_logic.calc_moves(0, piece, game)

	assert_eq(result.size(), 0, "Result should be empty.")


# Tests that a move can be added successfully.
func test_add_move_pass():
	piece_logic.add_move(custom_move)

	assert_eq(piece_logic.move_list.size(), 1, "Move list should have size 1")


# Tests that a move with an identical name is not inserted.
func test_add_move_fail_duplicate():
	# Directly add a move to the list.
	piece_logic.move_list.append(custom_move)

	assert_false(piece_logic.add_move(custom_move), "A move with the same name should be rejected.")


# Tests that a move can be removed by its name.
func test_remove_move_pass():
	# Directly add a move to the list.
	piece_logic.move_list.append(custom_move)

	var result = piece_logic.remove_move("custom_move")

	assert_eq(result.name, "custom_move",
		"custom_move should be removed from the move list.")


# Tests that a moves without a matching name are not removed.
func test_remove_move_fail():
	# Directly add a move to the list.
	piece_logic.move_list.append(custom_move)

	piece_logic.remove_move("non-existent_move")

	assert_eq(piece_logic.move_list.size(), 1, "Move list size should be unchanged, at 1")
	assert_eq(piece_logic.move_list[0].name, "custom_move", "custom_move should be the only move.")


# Tests that the list of the move names can be retrieved.
func test_get_move_names():
	# Empty list.
	var expected = []
	assert_eq_deep(piece_logic.get_move_names(), expected)

	# Directly add 2 moves to the list.
	piece_logic.move_list.append(custom_move)
	piece_logic.move_list.append(custom_move)
	expected.append("custom_move")
	expected.append("custom_move")

	assert_eq_deep(piece_logic.get_move_names(), expected)
