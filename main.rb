class Connect4

  def initialize
    @empty_board = '.' * 42

    board = @empty_board

    # show_board(board)
    # puts
    #
    # 1.upto(10) do |i|
    #   begin
    #     column = rand(7)
    #     playable = is_column_playable(board, column)
    #
    #     if playable
    #       board = play(board, column, i % 2 == 1 ? 'x' : 'o')
    #       show_board(board)
    #       puts
    #     end
    #   end while not playable
    # end


  end

  def play(board, column, player)
    lowest = 6 * column

    lowest.upto(lowest + 5) do |i|
      if board[i] == '.'
        board[i] = player
        return board
      end
    end

    nil
  end

  def is_column_playable(board, column)
    board[5 + 6 * column] == '.'
  end

  def show_board(board)
    puts board[5] + board[11] + board[17] + board[23] + board[29] + board[35] + board[41]
    puts board[4] + board[10] + board[16] + board[22] + board[28] + board[34] + board[40]
    puts board[3] +  board[9] + board[15] + board[21] + board[27] + board[33] + board[39]
    puts board[2] +  board[8] + board[14] + board[20] + board[26] + board[32] + board[38]
    puts board[1] +  board[7] + board[13] + board[19] + board[25] + board[31] + board[37]
    puts board[0] +  board[6] + board[12] + board[18] + board[24] + board[30] + board[36]
  end

end

Connect4.new
