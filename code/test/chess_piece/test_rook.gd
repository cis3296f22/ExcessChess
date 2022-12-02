extends GutTest
# Tests the rook chess piece movements.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const Rook = preload("res://engine/piece/rook.gd")


var game_state
var rook_logic
var rook_state


func before_all():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Load the rook chess piece logic.
	rook_logic = Rook.new()

	# Load the rook chess piece state.
	rook_state = PieceState.new(0, game_state.Team[1], rook_logic)


func after_each():
	# Clear the board.
	game_state = GameState.new(8, 8)


# Tests the movement of a rook that can move up, down, left, or right.
func test_rook_four_directions():
	var expected = [2, 10, 16, 17, 19, 20, 21, 22, 23, 26, 34, 42, 50, 58]
	var result

	# Add rook to c6.
	game_state.add(rook_state, 18)

	result = rook_logic.calc_moves(18, rook_state, game_state)

	_assert_eq_positions(result, expected)


# Tests the movement of a rook blocked by friendly pieces.
func test_rook_blocked():
	var block = [17, 19, 10, 26]
	var result

	# Add rook to c6.
	game_state.add(rook_state, 18)

	# Add duplicate rook states to block all of its moves.
	for pos in block:
		game_state.add(rook_state, pos)

	result = rook_logic.calc_moves(18, rook_state, game_state)

	assert_eq(result.size(), 0, "Result should be empty.")


# Tests the movement of a rook at the edge of the board.
func test_rook_edge():
	var expected = [1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 56]
	var result

	# Add rook to a8.
	game_state.add(rook_state, 0)

	result = rook_logic.calc_moves(0, rook_state, game_state)

	_assert_eq_positions(result, expected)

	# Move rook to h1.
	game_state.move(0, 63)

	expected = [7, 15, 23, 31, 39, 47, 55, 56, 57, 58, 59, 60, 61, 62]

	result = rook_logic.calc_moves(63, rook_state, game_state)

	_assert_eq_positions(result, expected)


func _assert_eq_positions(result, expected):
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
