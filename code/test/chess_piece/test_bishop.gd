extends GutTest
# Tests the bishop chess piece movements.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const Bishop = preload("res://engine/piece/bishop.gd")


var game_state
var bishop_logic
var bishop_state


func before_all():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Load the bishop chess piece logic.
	bishop_logic = Bishop.new()

	# Load the bishop chess piece state.
	bishop_state = PieceState.new(0, game_state.Team[1], bishop_logic)


func after_each():
	# Clear the board.
	game_state = GameState.new(8, 8)


# Tests the movement of a bishop that can move in four diagonal directions.
func test_bishop_four_directions():
	var expected = [9, 0, 11, 4, 25, 32, 27, 36, 45, 54, 63]
	var result

	# Add bishop to c6.
	game_state.add(bishop_state, 18)

	result = bishop_logic.calc_moves(18, bishop_state, game_state)

	_assert_eq_positions(result, expected)


# Tests the movement of a bishop blocked by friendly pieces.
func test_bishop_blocked():
	var block = [9, 11, 25, 27]
	var result

	# Add bishop to c6.
	game_state.add(bishop_state, 18)

	# Add duplicate bishop states to block all of its moves.
	for pos in block:
		game_state.add(bishop_state, pos)

	result = bishop_logic.calc_moves(18, bishop_state, game_state)

	assert_eq(result.size(), 0, "Result should be empty.")


# Tests the movement of a bishop at the edge of the board.
func test_bishop_edge():
	var expected = [25, 18, 11, 4, 41, 50, 59]
	var result

	# Add bishop to a4.
	game_state.add(bishop_state, 32)

	result = bishop_logic.calc_moves(32, bishop_state, game_state)

	_assert_eq_positions(result, expected)

	# Move bishop to h5.
	game_state.move(32, 31)

	expected = [22, 13, 4, 38, 45, 52, 59]

	result = bishop_logic.calc_moves(31, bishop_state, game_state)

	_assert_eq_positions(result, expected)


func _assert_eq_positions(result, expected):
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
