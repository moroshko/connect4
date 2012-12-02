require './connect4'

0.downto(0) do |i|
  c4 = Connect4.new

  player = (i % 2 == 0 ? 'x' : 'o')
  second_player = (i % 2 == 0 ? 'o' : 'x')

  boards = File.open("database/positions/#{i}moves.txt").readlines.map(&:chomp)

  result = boards.map do |board|
    game_results = (0..6).map do |column|
      if c4.is_column_playable(board, column)
        new_board = c4.play(board, column, player)
        c4.game_result(new_board)
      else
        ' '
      end
    end

    game_result = if game_results.include?(player)
      player
    elsif game_results.include?('?')
      '?'
    elsif game_results.include?('.')
      '.'
    elsif game_results.include?(second_player)
      second_player
    else
      raise "should not be here"
    end

    "#{board}|#{game_result}|#{game_results.join}"
  end

  File.open("database/game_result/#{i}moves.txt", 'w') do |f|
    f << result.join("\n") + "\n"
  end
end
