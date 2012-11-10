groups = []

# Horizontal
(0..5).each do |row|
  (0..3).each do |column|
    first = 6 * column + row
    groups << [first, first + 6, first + 12, first + 18]
  end
end

# Vertical
(0..2).each do |row|
  (0..6).each do |column|
    first = 6 * column + row
    groups << [first, first + 1, first + 2, first + 3]
  end
end

# Diagonal /
(0..2).each do |row|
  (0..3).each do |column|
    first = 6 * column + row
    groups << [first, first + 7, first + 14, first + 21]
  end
end

# Diagonal \
(3..5).each do |row|
  (0..3).each do |column|
    first = 6 * column + row
    groups << [first, first + 5, first + 10, first + 15]
  end
end

p groups
puts

group_indices_by_cell = []

groups.each_with_index do |group, index|
  group.each do |cell|
    if group_indices_by_cell[cell].nil?
      group_indices_by_cell[cell] = [index]
    else
      group_indices_by_cell[cell] << index
    end
  end
end

p group_indices_by_cell





