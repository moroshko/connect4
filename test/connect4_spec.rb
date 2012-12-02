require '../connect4'

c4 = Connect4.new

describe Connect4, "@groups" do
  it "should contain all win groups" do
    horizontal = 6 * 4
    vertical = 7 * 3
    diagonal_asc = 3 * 4
    diagonal_desc = diagonal_asc   # By symmetry
    c4.groups.size.should eq(horizontal + vertical + diagonal_asc + diagonal_desc)
  end
end

describe Connect4, "@group_indices_by_cell" do
  it "should contain the right groups for each cell" do
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

describe Connect4, "#column_playable?" do
  it "should work correctly" do
    board = '............xo....xoxoxo..................'
    c4.column_playable?(board, 0).should eq(true)
    c4.column_playable?(board, 2).should eq(true)
    c4.column_playable?(board, 3).should eq(false)
  end
end

describe Connect4, "#playable_cell" do
  describe "the column is not playable" do
    it "should return nil" do
      c4.playable_cell('............xo....xoxoxo..................', 3).should eq(nil)
    end
  end

  describe "the column is playable" do
    it "should return the cell number to play" do
      c4.playable_cell('............xo....xoxoxo..................', 2).should eq(14)
      c4.playable_cell('............xo....xoxoxo..................', 6).should eq(36)
    end
  end
end

describe Connect4, "#playable_columns" do
  it "should work correctly" do
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

describe Connect4, "#group_status" do
  it "should return nil if the group has no win" do
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [13, 14, 15, 16]).should eq(nil)
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [6, 7, 8, 9]).should eq(nil)
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [0, 6, 12, 18]).should eq(nil)
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [1, 7, 13, 19]).should eq(nil)
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [21, 26, 31, 36]).should eq(nil)
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [17, 23, 29, 35]).should eq(nil)
  end

  it "should return 'x' if the group has four 'x's" do
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', [23, 29, 35, 41]).should eq('x')
    c4.group_status('ooo...ooo...x.....oxoxoxxoxoxxxx....xoxoxx', [21, 26, 31, 36]).should eq('x')
  end

  it "should return 'o' if the group has four 'o's" do
    c4.group_status('ooox..oooo..x.....oxoxoxxoxoxxxoxoxxxoxox.', [6, 7, 8, 9]).should eq('o')
    c4.group_status('ooox..ooox..x.....oxoxoxxoxoxxxoo...xoxoxx', [18, 25, 32, 39]).should eq('o')
    c4.group_status('ooox..ooox..x.....oxoxoxxoxoxxxoo...xoxoxx', [22, 27, 32, 37]).should eq('o')
  end
end

describe Connect4, "#cell_to_column" do
  it "should work correctly" do
    c4.cell_to_column(0).should eq(0)
    c4.cell_to_column(7).should eq(1)
    c4.cell_to_column(14).should eq(2)
    c4.cell_to_column(21).should eq(3)
    c4.cell_to_column(28).should eq(4)
    c4.cell_to_column(35).should eq(5)
    c4.cell_to_column(41).should eq(6)
  end
end

describe Connect4, "#full_board?" do
  it "should return true if the board is full" do
    c4.full_board?('xoxoxoxoxoxoxoxoxooxoxoxxoxoxoxoxoxoxoxoxo').should eq(true)
  end

  it "should return false if the board is not full" do
    c4.full_board?('xoxoxoxoxoxoxoxoxooxoxoxxoxoxoxoxoxoxoxox.').should eq(false)
  end
end

describe Connect4, "#winner" do
  describe "with last move" do
    it "should return nil if there is no winner yet" do
      c4.winner('..........................................').should eq(nil)
      c4.winner('............xo....xoxoxo..................').should eq(nil)
      c4.winner('............xoxoxoxoxoxoxoxoxo............').should eq(nil)
    end

    it "should return '.' if game finished with draw" do
      c4.winner('xoxoxoxoxoxoxoxoxooxoxoxxoxoxoxoxoxoxoxoxo').should eq('.')
    end

    it "should return 'x' if 'x' won" do
      c4.winner('............xoxoxoxoxoxoxoxoxox...........').should eq('x')
      c4.winner('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx').should eq('x')
    end

    it "should return 'o' if 'o' won" do
      c4.winner('oo....xo....ooxx..xoxx....................').should eq('o')
      c4.winner('........................x.....xxx...oooo..').should eq('o')
    end
  end

  describe "without last move" do
    it "should return nil if the last move didn't win the game and the game didn't finish yet" do
      c4.winner('ooox..ooox..x.....oxoxoxxoxoxxxoxoxxxoxoxo', 3).should eq(nil)
      c4.winner('ooox..ooox..x.....oxoxoxxoxoxxxoxoxxxoxoxo', 23).should eq(nil)
      c4.winner('ooox..ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxo', 41).should eq(nil)
    end

    it "should return '.' if the last move finished the game with draw" do
      c4.winner('xoxoxoxoxoxoxoxoxooxoxoxxoxoxoxoxoxoxoxoxo', 35).should eq('.')
    end

    it "should return 'x' if last 'x's move won the game" do
      c4.winner('ooo...ooo...x.....oxoxoxxoxoxxxoxoxxxoxoxx', 35).should eq('x')
      c4.winner('ooo...ooox..xox...oxoxoxxoxoxxxoxoxxxoxox.', 14).should eq('x')
    end

    it "should return 'o' if last 'o's move won the game" do
      c4.winner('oooox.ooox..xo....oxoxoxxoxoxxxoxoxxxoxox.', 13).should eq('o')
      c4.winner('ooox..oooo..x.....oxoxoxxoxoxxxoxoxxxoxox.', 9).should eq('o')
    end
  end
end

describe Connect4, "#can_win" do
  describe "cannot win immediately" do
    describe "'x's move" do
      it "should return nil" do
        c4.can_win('..........................................').should eq(nil)
        c4.can_win('............ox....xoxo..xoo...............').should eq(nil)
      end
    end

    describe "'o's move" do
      it "should return nil" do
        c4.can_win('xx....xx....oo....o.......................').should eq(nil)
        c4.can_win('............ox....xox...xoox..............').should eq(nil)
      end
    end
  end

  describe "can win immediately" do
    describe "'x's move" do
      it "should return a winning cell" do
        c4.can_win('............ox....xoxo..xoox..............').should eq(6)
        [33, 36].should include(c4.can_win('............ox....xoxo..xoox..xox.........'))
        [9, 33].should include(c4.can_win('......ooo...oxox..xoxx..ooox..xxx.........'))
      end
    end

    describe "'o's move" do
      it "should return a winning cell if 'o' can win immediately" do
        c4.can_win('......o.....o.....xoox..xxxo..x...........').should eq(13)
        [0, 26, 41].should include(c4.can_win('......xooxxoxxoxoxxoooxxox....oxxoxxoxooo.'))
      end
    end
  end
end

describe Connect4, "#forced_move" do
  describe "next move is not forced" do
    describe "'x's move" do
      it "should return nil" do
        c4.forced_move('..........................................').should eq(nil)
        c4.forced_move('............xo....xoo...oox.........xx....').should eq(nil)
      end
    end

    describe "'o's move" do
      it "should return nil if 'o's next move is not forced" do
        c4.forced_move('............xo....x.......................').should eq(nil)
        c4.forced_move('............xo....xoo...oox.........xx....').should eq(nil)
      end
    end
  end

  describe "next move is forced" do
    describe "'x's move" do
      it "should return a cell where 'x' can lose" do
        c4.forced_move('......xooo..x.................oxx.........').should eq(10)
        [7, 15].should include(c4.forced_move('......x.....xoo...xoox..oox...o.....xx....'))
      end
    end

    describe "'o's move" do
      it "should return a cell where 'o' can lose" do
        [0, 31, 39].should include(c4.forced_move('......x.....xoo...xoox..oox...o.....xxx...'))
      end
    end
  end
end

describe Connect4, "#mirror" do
  it "should work correctly" do
    c4.mirror('............x.....xo....o.................').should eq('............o.....xo....x.................')
    c4.mirror('............xo....xoxoxo..................').should eq('..................xoxoxoxo................')
    c4.mirror('x.....oo....xxx...xo....ooo...xx....o.....').should eq('o.....xx....ooo...xo....xxx...oo....x.....')
  end
end

describe Connect4, "#game_result" do
  it "should work correctly" do
    c4.game_result('xoxx..oox...o.............................').should eq('x')
    c4.game_result('xoxo..............o.....xox...............').should eq('o')
    c4.game_result('xoxo........oxo...x.......................').should eq('.') # Draw
    c4.game_result('xoxx..ooo...x.............................').should eq('?') # Game result is unknown
    c4.game_result('xoxx..ox....o.....o.......................').should eq('?') # Game result is unknown
  end
end

describe Connect4, "#symmetry_possible?" do
  it "should return true if a symmetric position is possible" do
    c4.symmetry_possible?('..........................................').should eq(true)
    c4.symmetry_possible?('x.....xo....oxoox.xoxoxoox..........x.....').should eq(true)
  end

  it "should return false if a symmetric position is not possible" do
    c4.symmetry_possible?('x...................................o.....').should eq(false)
    c4.symmetry_possible?('x.....xo....oxoox.xoxoxoox....o.....x.....').should eq(false)
  end
end

describe Connect4, "#read_database" do
  it "should work correctly" do
    c4.db[7]['......xoxoxo......x.......................'].should eq({
      :game_result => '.',
      :win_moves => [],
      :lose_moves => [0, 3, 5, 6],
      :draw_moves => [2, 4],
      :unknown_moves => []
    })

    c4.db[7]['xox...o.....x.....xo......................'].should eq({
      :game_result => 'o',
      :win_moves => [3, 5],
      :lose_moves => [6],
      :draw_moves => [0, 4],
      :unknown_moves => [1, 2]
    })

    c4.db[7]['......xox...xx..........o...........o.....'].should eq({
      :game_result => '?',
      :win_moves => [],
      :lose_moves => [0, 1, 4, 6],
      :draw_moves => [2],
      :unknown_moves => [3, 5]
    })

    c4.db[7]['......xo....xoxx....................o.....'].should eq({
      :game_result => 'x',
      :win_moves => [],
      :lose_moves => [0, 1, 2, 3, 4, 5, 6],
      :draw_moves => [],
      :unknown_moves => []
    })

    c4.db[8]['......x...........xoxooxo.................'][:game_result].should eq('o')
    c4.db[8]['x.................xoxooox.................'][:game_result].should eq('x')
    c4.db[8]['o.................xoxoxxo.................'][:game_result].should eq('.')
  end
end

describe Connect4, "#search_game_result" do
  # describe "after 8 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxo...x.....o.................').should eq('x')
  #   end
  # end

  describe "after 12 moves" do
    it "should work correctly" do
      c4.search_game_result('x.....xo....oxo...xoxo..ox................').should eq('x')
      puts "search_memo = #{c4.search_memo.size}"
    end
  end

  # describe "after 13 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxo...xoxox.ox................').should eq('x')
  #   end
  # end

  # describe "after 14 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxoo..xoxox.ox................').should eq('x')
  #   end
  # end

  # describe "after 15 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxoox.xoxox.ox................').should eq('x')
  #   end
  # end

  # describe "after 16 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxoox.xoxoxoox................').should eq('x')
  #   end
  # end

  # describe "after 17 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxoox.xoxoxoox..........x.....').should eq('x')
  #   end
  # end

  # describe "after 18 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxooxoxoxoxoox..........x.....').should eq('x')
  #   end
  # end

  # describe "after 19 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxooxoxoxoxooxx.........x.....').should eq('x')
  #   end
  # end

  # describe "after 20 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('x.....xo....oxoxo.xoxox.oxxoxoo...........').should eq('x')
  #   end
  # end
  #
  # describe "after 23 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('xxxo..xooxoxoxooxoxx....oxxo........o.....').should eq('x')
  #   end
  # end
  #
  # describe "after 28 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('xx....xo....oxoooxxoxoxxooxoxoooxxxo......').should eq('o')
  #   end
  # end
  #
  # describe "after 33 moves" do
  #   it "should work correctly" do
  #     c4.search_game_result('xoxoxo......xoxoxoooxoxoxxoxxxoxo...xoooxx').should eq('o')
  #   end
  # end
end




