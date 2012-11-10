require './connect4'

c4 = Connect4.new

c4.all_boards_after_n_moves(2).map do |board|
  c4.show_board(board)
  puts
end
