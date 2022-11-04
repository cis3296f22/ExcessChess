extends Piece
# Pawn represents the pawn chess piece.


func _init(team_new, id_new).(team_new, Type.PAWN, id_new):
    pass


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
    var moves = []
    var sgn = 1 if team == Team.BLACK else -1
    var new_pos

    # Get forward movements.
    new_pos = orig_pos + sgn * board_width
    _add_move(moves, new_pos, max_pos, board_map)
    if not has_moved:
        _add_move(moves, new_pos + sgn * board_width, max_pos, board_map)
    # Get diagonal captures.
    _add_capture(moves, new_pos + 1, board_map)
    _add_capture(moves, new_pos -1, board_map)

    # TODO Implement en passant validation using prev_move.
    return moves


# Checks if a space is unoccupied, and if so, adds it to the list of moves.
# Arguments:
# moves: The list of moves.
# new_pos: The prospective position.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
func _add_move(moves, new_pos, max_pos, board_map):
    if not board_map.has(new_pos) and new_pos >= 0 and new_pos <= max_pos:
        moves.append(new_pos)


# Checks if a space is occupied and can be captured, and if so, adds it to the
# list of moves.
# Arguments:
# moves: The list of moves.
# new_pos: The prospective position.
# board_map: The map of board positions and chess pieces.
func _add_capture(moves, new_pos, board_map):
    if board_map.has(new_pos) and board_map[new_pos].get("team") != team:
        moves.append(new_pos)
