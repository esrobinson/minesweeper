class Board

  def initialize

  end

  def won?
    false
    true if #(all mines flagged && no of mines == no of flags) || all others              revealed
  end

  def lost?
    true if #last move was a mine
  end

end