extends Piece
# Bishop represents the bishop chess piece.


const linear = preload("res://engine/move/linear_move.gd")


func _init(team_new, id_new).(team_new, Type.BISHOP, id_new):
    pass


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
    var moves = []
    var start_file = orig_pos % board_width

    # Get movements.
    linear.add_moves(moves, team, orig_pos + board_width + 1, orig_pos + (board_width - start_file - 1) * (board_width + 1),
            board_width + 1, max_pos, board_map)
    linear.add_moves(moves, team, orig_pos + board_width - 1, orig_pos + (start_file) * (board_width - 1),
            board_width - 1, max_pos, board_map)
    linear.add_moves(moves, team, orig_pos - board_width - 1, orig_pos + (start_file) * (-1 - board_width),
            -1 - board_width, max_pos, board_map)
    linear.add_moves(moves, team, orig_pos - board_width + 1, orig_pos + (board_width - start_file - 1) * (1 - board_width),
            1 - board_width, max_pos, board_map)

    return moves
