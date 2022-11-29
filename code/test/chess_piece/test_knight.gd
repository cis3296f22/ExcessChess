extends GutTest
# Tests the knight chess piece movements.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const Knight = preload("res://engine/piece/knight.gd")


var game_state
var knight_logic
var knight_state


func before_all():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Load the knight chess piece logic.
	knight_logic = Knight.new()

	# Load the knight chess piece state.
	knight_state = PieceState.new(0, game_state.Team[1], knight_logic.name)


func after_each():
	# Clear the board.
	game_state = GameState.new(8, 8)


# Tests the movement of a knight with full freedom of movement.
func test_knight_full():
	var expected = [1, 3, 8, 12, 24, 28, 33, 35]
	var result

	# Add knight to c6.
	game_state.add(knight_state, 18)

	result = knight_logic.calc_moves(18, knight_state, game_state)

	_assert_eq_positions(result, expected)


# Tests the movement of a knight blocked by friendly pieces.
func test_knight_blocked():
	var block = [1, 3, 8, 12, 24, 28, 33, 35]
	var result

	# Add knight to c6.
	game_state.add(knight_state, 18)

	# Add duplicate knight states to block all of its moves.
	for pos in block:
		game_state.add(knight_state, pos)

	result = knight_logic.calc_moves(18, knight_state, game_state)

	assert_eq(result.size(), 0, "Result should be empty.")


# Tests the movement of a knight near the edge of the board.
func test_knight_edge():
	var expected = [10, 17]
	var result

	# Add knight to a8.
	game_state.add(knight_state, 0)

	result = knight_logic.calc_moves(0, knight_state, game_state)

	_assert_eq_positions(result, expected)

	# Move knight to h4.
	game_state.move(0, 39)

	expected = [22, 29, 45, 54]

	result = knight_logic.calc_moves(39, knight_state, game_state)

	_assert_eq_positions(result, expected)


func _assert_eq_positions(result, expected):
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
