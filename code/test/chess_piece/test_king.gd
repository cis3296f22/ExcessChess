extends GutTest
# Tests the king chess piece movements.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const King = preload("res://engine/piece/king.gd")


var game_state
var king_logic
var king_state


func before_all():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Load the king chess piece logic.
	king_logic = King.new()

	# Load the king chess piece state.
	king_state = PieceState.new(0, game_state.Team[1], king_logic.name)


func after_each():
	# Clear the board.
	for index in game_state.pieces_cord:
		game_state.remove(index)

	# Reset the king state.
	king_state.set("has_moved", false)


# Tests the movement of a king that can move in eight directions.
func test_king_eight_directions():
	var expected = [9, 10, 11, 17, 19, 25, 26, 27]
	var result

	# Add king to c6.
	game_state.add(king_state, 18)

	result = king_logic.calc_moves(18, king_state, game_state)

	_assert_eq_positions(result, expected)


# Tests the movement of a king blocked by friendly pieces.
func test_king_blocked():
	var block = [9, 10, 11, 17, 19, 25, 26, 27]
	var result

	# Add king to c6.
	game_state.add(king_state, 18)

	# Add duplicate king states to block all of its moves.
	for pos in block:
		game_state.add(king_state, pos)

	result = king_logic.calc_moves(18, king_state, game_state)

	assert_eq(result.size(), 0, "Result should be empty.")


# Tests the movement of a king at the edge of the board.
func test_king_edge():
	var expected = [6, 14, 15]
	var result

	# Add king to h8.
	game_state.add(king_state, 7)

	result = king_logic.calc_moves(7, king_state, game_state)

	_assert_eq_positions(result, expected)

	# Move king to a1.
	game_state.move(7, 56)

	expected = [48, 49, 57]

	result = king_logic.calc_moves(56, king_state, game_state)

	_assert_eq_positions(result, expected)


# Tests kingside castling validation.
func test_king_kingside_castling():
	# TODO Test kingside castling.
	pending()

# Tests queenside castling validation.
func test_king_queenside_castling():
	# TODO Test kingside castling.
	pending()


func _assert_eq_positions(result, expected):
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
