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
	for index in game_state.pieces_cord:
		game_state.remove(index)


# Tests the movement of a knight with full freedom of movement.
func test_knight_full():
	var expected = [1, 3, 8, 12, 24, 28, 33, 35]
	var result

	# Add knight to the middle of the board.
	game_state.add(knight_state, 18)

	# Calculate the knight's moves.
	result = knight_logic.calc_moves(18, knight_state, game_state)

	# Check the results against the expected output.
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
