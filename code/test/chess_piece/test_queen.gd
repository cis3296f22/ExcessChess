extends GutTest
# Tests the queen chess piece movements.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const Queen = preload("res://engine/piece/queen.gd")


var game_state
var queen_logic
var queen_state


func before_all():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Load the queen chess piece logic.
	queen_logic = Queen.new()

	# Load the queen chess piece state.
	queen_state = PieceState.new(0, game_state.Team[1], queen_logic)


func after_each():
	# Clear the board.
	game_state = GameState.new(8, 8)


# Tests the movement of a queen that can move in eight linear directions.
func test_queen_eight_directions():
	var expected = [2, 10, 16, 17, 19, 20, 21, 22, 23, 26, 34, 42, 50, 58,
			9, 0, 11, 4, 25, 32, 27, 36, 45, 54, 63]
	var result

	# Add queen to c6.
	game_state.add(queen_state, 18)

	result = queen_logic.calc_moves(18, queen_state, game_state)

	_assert_eq_positions(result, expected)


# Tests the movement of a queen blocked by friendly pieces.
func test_queen_blocked():
	var block = [17, 19, 10, 26, 9, 11, 25, 27]
	var result

	# Add queen to c6.
	game_state.add(queen_state, 18)

	# Add duplicate queen states to block all of its moves.
	for pos in block:
		game_state.add(queen_state, pos)

	result = queen_logic.calc_moves(18, queen_state, game_state)

	assert_eq(result.size(), 0, "Result should be empty.")


# Tests the movement of a queen at the edge of the board.
func test_queen_edge():
	var expected = [1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 56,
			9, 18, 27, 36, 45, 54, 63]
	var result

	# Add queen to a8.
	game_state.add(queen_state, 0)

	result = queen_logic.calc_moves(0, queen_state, game_state)

	_assert_eq_positions(result, expected)

	# Move queen to h1.
	game_state.move(0, 63)

	expected = [7, 15, 23, 31, 39, 47, 55, 56, 57, 58, 59, 60, 61, 62,
			0, 9, 18, 27, 36, 45, 54]

	result = queen_logic.calc_moves(63, queen_state, game_state)

	_assert_eq_positions(result, expected)


func _assert_eq_positions(result, expected):
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
