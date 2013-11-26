class Leaderboard

  def initialize(board_size, number_of_mines)
    @board_size = board_size
    @number_of_mines = number_of_mines
    @leaders = []
  end

  def add_leader(leader)
    @leaders << leader
  end

  def print_best(number = 10)
    number = [leaders.count, number].min
    @leaders.sort[0...number].each do |leader|
      puts "#{leader.name}: #{leader.time}"
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