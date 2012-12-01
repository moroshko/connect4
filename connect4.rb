class Connect4

  attr_accessor :groups, :group_indices_by_cell, :db

  def initialize
    @empty_board = '.' * 42
    @groups = [[0, 6, 12, 18], [6, 12, 18, 24], [12, 18, 24, 30], [18, 24, 30, 36], [1, 7, 13, 19], [7, 13, 19, 25], [13, 19, 25, 31], [19, 25, 31, 37], [2, 8, 14, 20], [8, 14, 20, 26], [14, 20, 26, 32], [20, 26, 32, 38], [3, 9, 15, 21], [9, 15, 21, 27], [15, 21, 27, 33], [21, 27, 33, 39], [4, 10, 16, 22], [10, 16, 22, 28], [16, 22, 28, 34], [22, 28, 34, 40], [5, 11, 17, 23], [11, 17, 23, 29], [17, 23, 29, 35], [23, 29, 35, 41], [0, 1, 2, 3], [6, 7, 8, 9], [12, 13, 14, 15], [18, 19, 20, 21], [24, 25, 26, 27], [30, 31, 32, 33], [36, 37, 38, 39], [1, 2, 3, 4], [7, 8, 9, 10], [13, 14, 15, 16], [19, 20, 21, 22], [25, 26, 27, 28], [31, 32, 33, 34], [37, 38, 39, 40], [2, 3, 4, 5], [8, 9, 10, 11], [14, 15, 16, 17], [20, 21, 22, 23], [26, 27, 28, 29], [32, 33, 34, 35], [38, 39, 40, 41], [0, 7, 14, 21], [6, 13, 20, 27], [12, 19, 26, 33], [18, 25, 32, 39], [1, 8, 15, 22], [7, 14, 21, 28], [13, 20, 27, 34], [19, 26, 33, 40], [2, 9, 16, 23], [8, 15, 22, 29], [14, 21, 28, 35], [20, 27, 34, 41], [3, 8, 13, 18], [9, 14, 19, 24], [15, 20, 25, 30], [21, 26, 31, 36], [4, 9, 14, 19], [10, 15, 20, 25], [16, 21, 26, 31], [22, 27, 32, 37], [5, 10, 15, 20], [11, 16, 21, 26], [17, 22, 27, 32], [23, 28, 33, 38]]
    @group_indices_by_cell = [[0, 24, 45], [4, 24, 31, 49], [8, 24, 31, 38, 53], [12, 24, 31, 38, 57], [16, 31, 38, 61], [20, 38, 65], [0, 1, 25, 46], [4, 5, 25, 32, 45, 50], [8, 9, 25, 32, 39, 49, 54, 57], [12, 13, 25, 32, 39, 53, 58, 61], [16, 17, 32, 39, 62, 65], [20, 21, 39, 66], [0, 1, 2, 26, 47], [4, 5, 6, 26, 33, 46, 51, 57], [8, 9, 10, 26, 33, 40, 45, 50, 55, 58, 61], [12, 13, 14, 26, 33, 40, 49, 54, 59, 62, 65], [16, 17, 18, 33, 40, 53, 63, 66], [20, 21, 22, 40, 67], [0, 1, 2, 3, 27, 48, 57], [4, 5, 6, 7, 27, 34, 47, 52, 58, 61], [8, 9, 10, 11, 27, 34, 41, 46, 51, 56, 59, 62, 65], [12, 13, 14, 15, 27, 34, 41, 45, 50, 55, 60, 63, 66], [16, 17, 18, 19, 34, 41, 49, 54, 64, 67], [20, 21, 22, 23, 41, 53, 68], [1, 2, 3, 28, 58], [5, 6, 7, 28, 35, 48, 59, 62], [9, 10, 11, 28, 35, 42, 47, 52, 60, 63, 66], [13, 14, 15, 28, 35, 42, 46, 51, 56, 64, 67], [17, 18, 19, 35, 42, 50, 55, 68], [21, 22, 23, 42, 54], [2, 3, 29, 59], [6, 7, 29, 36, 60, 63], [10, 11, 29, 36, 43, 48, 64, 67], [14, 15, 29, 36, 43, 47, 52, 68], [18, 19, 36, 43, 51, 56], [22, 23, 43, 55], [3, 30, 60], [7, 30, 37, 64], [11, 30, 37, 44, 68], [15, 30, 37, 44, 48], [19, 37, 44, 52], [23, 44, 56]]
    read_database
  end

  def playable_cell(board, column)
    lowest = 6 * column

    lowest.upto(lowest + 5) do |cell|
      return cell if board[cell] == '.'
    end

    nil
  end

  def play(board, column, player)
    cell = playable_cell(board, column)

    if cell.nil?
      nil
    else
      new_board = board.dup
      new_board[cell] = player
      new_board
    end
  end

  def is_column_playable(board, column)
    board[5 + 6 * column] == '.'
  end

  def playable_columns(board)
    (0..6).select do |column|
      is_column_playable(board, column)
    end
  end

  def show_board(board)
    puts board[5] + board[11] + board[17] + board[23] + board[29] + board[35] + board[41]
    puts board[4] + board[10] + board[16] + board[22] + board[28] + board[34] + board[40]
    puts board[3] +  board[9] + board[15] + board[21] + board[27] + board[33] + board[39]
    puts board[2] +  board[8] + board[14] + board[20] + board[26] + board[32] + board[38]
    puts board[1] +  board[7] + board[13] + board[19] + board[25] + board[31] + board[37]
    puts board[0] +  board[6] + board[12] + board[18] + board[24] + board[30] + board[36]
  end

  def group_status(board, group)
    if (board[group[0]] == 'x') and (board[group[1]] == 'x') and (board[group[2]] == 'x') and (board[group[3]] == 'x')
      'x'
    elsif (board[group[0]] == 'o') and (board[group[1]] == 'o') and (board[group[2]] == 'o') and (board[group[3]] == 'o')
      'o'
    else
      nil
    end
  end

  def winner(board, last_move = nil)
    if last_move.nil?
      @groups.each do |group|
        status = group_status(board, group)
        return status unless status.nil?
      end
    else
      @group_indices_by_cell[last_move].each do |group_index|
        status = group_status(board, @groups[group_index])
        return status unless status.nil?
      end
    end

    nil
  end

  def can_win(board, player = nil)
    if player.nil?
      player = (board.count('.') % 2 == 0 ? 'x' : 'o')
    end

    playable_columns(board).each do |column|
      cell = playable_cell(board, column)
      return cell unless winner(play(board, column, player), cell).nil?
    end

    nil
  end

  def forced_move(board)
    can_win(board, board.count('.') % 2 == 0 ? 'o' : 'x')
  end

  def mirror(board)
    board[36..41] + board[30..35] + board[24..29] + board[18..23] + board[12..17] + board[6..11] + board[0..5]
  end

  def game_result(board)
    moves_played = 42 - board.count('.')

    return @db[moves_played][board][:game_result] if @db[moves_played][board]

    mirrored_board = mirror(board)
    return @db[moves_played][mirrored_board][:game_result] if @db[moves_played][mirrored_board]

    player = (moves_played % 2 == 0 ? 'x' : 'o')
    return player if can_win(board, player)

    return '?' if forced_move(board)

    raise "should not be here"
  end

  def all_boards_after_n_moves(i, n)
    return [@empty_board] if i == 0

    player = (i % 2 == 1 ? 'x' : 'o')
    result = {}

    all_boards_after_n_moves(i - 1, n).select{ |board| winner(board).nil? }.each do |board|
      playable_columns(board).each do |column|
        new_board = play(board, column, player)

        if result[new_board].nil? && result[mirror(new_board)].nil? &&
           winner(new_board).nil? &&
           (i < n || can_win(new_board).nil? && forced_move(new_board).nil?)
          result[new_board] = true
        end
      end
    end

    result.keys
  end

  def read_database
    @db = {}

    8.downto(7) do |i|
      @db[i] = {}

      File.open(File.dirname(__FILE__) + "/database/game_result/#{i}moves.txt").readlines.map(&:chomp).each do |record|
        board = record[0..41]
        game_result = record[43]

        @db[i][board] = { :game_result => game_result }

        if record.size > 44
          game_results = record[45..51].split('')
          player = (i % 2 == 0 ? 'x' : 'o')
          second_player = (i % 2 == 0 ? 'o' : 'x')

          @db[i][board][:win_moves] = (0..6).select { |i| game_results[i] == player }
          @db[i][board][:lose_moves] = (0..6).select { |i| game_results[i] == second_player }
          @db[i][board][:draw_moves] = (0..6).select { |i| game_results[i] == '.' }
          @db[i][board][:unknown_moves] = (0..6).select { |i| game_results[i] == '?' }
        end
      end
    end
  end

end

