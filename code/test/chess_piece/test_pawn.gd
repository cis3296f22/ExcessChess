extends GutTest
# Tests the pawn chess piece movements.
const GameState = preload("res://engine/game_state.gd")
const PieceState = preload("res://engine/piece/piece_state.gd")
const Pawn = preload("res://engine/piece/pawn.gd")


var game_state
var pawn_logic
var pawn_state


func before_all():
	# Create a standard 8x8 chess board.
	game_state = GameState.new(8, 8)

	# Load the pawn chess piece logic.
	pawn_logic = Pawn.new()

	# Load the pawn chess piece states. Team 0 moves up, Team 1 moves down.
	pawn_state = []
	pawn_state.append(PieceState.new(0, game_state.Team[0], pawn_logic.name))
	pawn_state.append(PieceState.new(0, game_state.Team[1], pawn_logic.name))


func after_each():
	# Clear the board.
	game_state = GameState.new(8, 8)

	# Reset the has_moved state of pawns.
	pawn_state[0].set("has_moved", false)
	pawn_state[1].set("has_moved", false)

# Tests the first, free movement of a pawn with no pieces to capture.
func test_pawn_first_move_free():
	var result

	# Add pawn to d4.
	game_state.add(pawn_state[0], 35)

	# Assert that Team 0 moves up.
	result = pawn_logic.calc_moves(35, pawn_state[0], game_state)
	_assert_eq_positions(result, [27, 19])

	# Assert that Team 1 moves down.
	result = pawn_logic.calc_moves(35, pawn_state[1], game_state)
	_assert_eq_positions(result, [43, 51])


# Tests the movement of a pawn whose 2-space movement is blocked by an enemy piece,
# but it is free to move 1-space forward.
func test_pawn_first_move_blocked():
	var result

	# Add pawn to h4.
	game_state.add(pawn_state[0], 39)

	# Add blocker pawn.
	game_state.add(pawn_state[1], 23)

	result = pawn_logic.calc_moves(39, pawn_state[0], game_state)
	_assert_eq_positions(result, [31])


# Tests if a pawn has moved, then it cannot move forward 2 spaces.
func test_pawn_move():
	var result

	# Prepare pawn states.
	pawn_state[0].set("has_moved", true)
	pawn_state[1].set("has_moved", true)

	# Add pawn to d4.
	game_state.add(pawn_state[0], 35)

	# Assert that Team 0 moves up.
	result = pawn_logic.calc_moves(35, pawn_state[0], game_state)
	_assert_eq_positions(result, [27])

	# Assert that Team 1 moves down.
	result = pawn_logic.calc_moves(35, pawn_state[1], game_state)
	_assert_eq_positions(result, [43])


# Tests the movement of a pawn on the edge of the board, that can capture an enemy piece.
func test_pawn_capture_edge():
	var result

	# Prepare pawn states.
	pawn_state[0].set("has_moved", true)
	pawn_state[1].set("has_moved", true)

	# Add pawn to h4.
	game_state.add(pawn_state[0], 39)

	# Add capturable pawns.
	game_state.add(pawn_state[1], 30)
	game_state.add(pawn_state[0], 46)

	# Assert that Team 0 moves up or captures up-left.
	result = pawn_logic.calc_moves(39, pawn_state[0], game_state)
	_assert_eq_positions(result, [30, 31])

	# Assert that Team 1 moves down or captures down-left.
	result = pawn_logic.calc_moves(39, pawn_state[1], game_state)
	_assert_eq_positions(result, [46, 47])

	# Move pawns to the opposite side.
	game_state.move(39, 32)
	game_state.move(30, 25)
	game_state.move(46, 41)

	# Assert that Team 0 moves up or captures up-right.
	result = pawn_logic.calc_moves(32, pawn_state[0], game_state)
	_assert_eq_positions(result, [24, 25])

	# Assert that Team 1 moves down or captures down-right.
	result = pawn_logic.calc_moves(32, pawn_state[1], game_state)
	_assert_eq_positions(result, [40, 41])

# Tests the movement of a pawn that is blocked by an enemy piece.
func test_pawn_blocked():
	var result

	# Add pawn to h4.
	game_state.add(pawn_state[0], 39)

	# Add blocker pawn.
	game_state.add(pawn_state[1], 31)

	result = pawn_logic.calc_moves(39, pawn_state[0], game_state)
	assert_eq(result.size(), 0, "Result should be empty.")


# Tests the en passant movement.
func test_pawn_en_passant():
	# TODO Implement en passant test. This requires the game state move stack.
	pending()


func _assert_eq_positions(result, expected):
	assert_eq(result.size(), expected.size(), "Number of positions should be equal.")
	for pos in expected:
		assert_has(result, pos, "Result should contain position " + str(pos))
