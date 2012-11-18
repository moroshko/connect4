require './connect4'

c4 = Connect4.new

(0..8).each do |n|
  boards = c4.all_boards_after_n_moves(n, n)

  File.open("database/positions/#{n}moves.txt", 'w') do |f|
    f << boards.join("\n") + "\n"
  end

  puts "#{n} moves - #{boards.size} positions"
end
