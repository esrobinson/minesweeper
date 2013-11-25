class Game

  def initialize
    @board = nil
  end

  def play
    @board = Board.new

    until @board.won? || @board.lost?

  end



end