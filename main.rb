require './connect4'

c4 = Connect4.new

(0..8).each do |n|
  boards = c4.all_boards_after_n_moves(n)

  File.open("database/#{n}moves.txt", 'w') do |f|
    f << boards.join("\n")
  end

  puts "#{n} moves - #{boards.size} positions"
end
