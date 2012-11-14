require './connect4'

c4 = Connect4.new

my_positions = File.open('database/8moves.txt').readlines.map(&:chomp)
john_positions = File.open('8moves-john.txt').readlines.map(&:chomp)

john_extra = john_positions - my_positions
john_extra.reject! do |board|
  my_positions.include?(c4.mirror(board))
end

my_extra = my_positions - john_positions
my_extra.reject! do |board|
  john_positions.include?(c4.mirror(board))
end

puts "John has #{john_extra.size} extra positions"
puts "I have #{my_extra.size} extra positions"

if john_extra.size > 0
  puts "-" * 50
  puts "John's extra position:"
  c4.show_board(john_extra[0])
  puts john_extra[0]
end

if my_extra.size > 0
  puts "-" * 50
  puts "My extra position:"
  c4.show_board(my_extra[0])
  puts my_extra[0]
end

puts "-" * 50
