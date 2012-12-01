require './connect4'

c4 = Connect4.new

my_boards = File.open('database/positions/8moves.txt').readlines.map(&:chomp)
john_results = File.open('database/8moves.txt').readlines.map(&:chomp)

john_boards = {}

john_results.each do |john_result|
  john_boards[john_result[0..41]] = john_result[42]
end

result = []

my_boards.each_with_index do |board, i|
  if john_boards[board].nil?
    mirrored_board = c4.mirror(board)

    if john_boards[mirrored_board].nil?
      abort("Board not found in John's database: #{board}")
    else
      game_result = john_boards[mirrored_board]
    end
  else
    game_result = john_boards[board]
  end

  game_result = case game_result
    when '0' then 'o'
    when '1' then '.'
    when '2' then 'x'
  end

  result << "#{board}|#{game_result}"
end

File.open("database/game_result/8moves.txt", 'w') do |f|
  f << result.join("\n") + "\n"
end
