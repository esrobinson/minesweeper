class LeaderBoard

  def initialize(board_size = 9, number_of_mines = 9)
    @board_size = board_size
    @number_of_mines = number_of_mines
    @leaders = []
  end

  def add_leader(leader)
    @leaders << leader
  end

  def print_best(number = 10)
    number = [@leaders.count, number].min
    @leaders.sort[0...number].each do |leader|
      puts "#{leader.name}: #{leader.time}"
    end
  end

  def save
    File.open('leaderboard.txt', 'w') { |f| f.puts self.to_yaml }
  end

  def self.load
    if File.exists?('leaderboard.txt')
      YAML.load(File.read('leaderboard.txt'))
    else
      LeaderBoard.new
    end
  end


end

class Leader
  attr_reader :name, :time

  def initialize(name, time)
    @name, @time = name, time
  end


  def <=>(other_leader)
    @time <=> other_leader.time
  end

end