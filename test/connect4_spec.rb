require '../connect4'

describe Connect4, "@groups" do
  it "should contain all win groups" do
    c4 = Connect4.new
    horizontal = 6 * 4
    vertical = 7 * 3
    diagonal_asc = 3 * 4
    diagonal_desc = diagonal_asc   # By symmetry
    c4.groups.size.should eq(horizontal + vertical + diagonal_asc + diagonal_desc)
  end
end

describe Connect4, "@group_indices_by_cell" do
  it "should contain the right groups for each cell" do
    c4 = Connect4.new
    c4.group_indices_by_cell[6].size.should eq(4)
    c4.group_indices_by_cell[20].size.should eq(13)
    c4.group_indices_by_cell[41].size.should eq(3)

    (0..41).each do |cell|
      c4.group_indices_by_cell[cell].each do |group_index|
        c4.groups[group_index].should include(cell)
      end
    end
  end
end

describe Connect4, "#is_column_playable" do
  it "should work correctly" do
    c4 = Connect4.new
    board = '............xo....xoxoxo..................'
    c4.is_column_playable(board, 0).should eq(true)
    c4.is_column_playable(board, 2).should eq(true)
    c4.is_column_playable(board, 3).should eq(false)
  end
end

describe Connect4, "#playable_columns" do
  it "should work correctly" do
    c4 = Connect4.new
    board = '..........................................'
    c4.playable_columns(board).should eq([0, 1, 2, 3, 4, 5, 6])

    board = '............xo....xoxoxo............oxxxoo'
    c4.playable_columns(board).should eq([0, 1, 2, 4, 5])

    board = 'xoxoxoxoxoxoxoxoxooxoxoxxoxoxoxoxoxoxoxoxo'
    c4.playable_columns(board).should eq([])
  end
end

describe Connect4, "#play" do
  it "should work correctly" do
    c4 = Connect4.new
    board = '............xo....xoxoxo..................'

    board = c4.play(board, 1, 'x')
    board.should eq('......x.....xo....xoxoxo..................')

    board = c4.play(board, 2, 'o')
    board.should eq('......x.....xoo...xoxoxo..................')

    c4.play(board, 3, 'x').should eq(nil)

    board = c4.play(board, 6, 'x')
    board.should eq('......x.....xoo...xoxoxo............x.....')

    board = c4.play(board, 5, 'o')
    board.should eq('......x.....xoo...xoxoxo......o.....x.....')

    board = c4.play(board, 5, 'x')
    board.should eq('......x.....xoo...xoxoxo......ox....x.....')
  end
end



