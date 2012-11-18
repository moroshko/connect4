# Source of 'connect-4.data': http://archive.ics.uci.edu/ml/datasets/Connect-4

f = File.new('database/8moves.txt', 'w')

IO.readlines('connect-4.data').each do |line|
  f.write line.gsub('loss', '0')
              .gsub('draw', '1')
              .gsub('win', '2')
              .gsub('b', '.')
              .gsub(',', '')
end

f.close
