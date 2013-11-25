class Board

  def initialize
    @tiles = Array.new(9) { Array.new(9) { Tile.new() } }
  end

  def make_move(move)
    move_type, coords = move
    move_type == "f" ? flag(coords) : reveal(coords)
  end



  def won?
    false
    true if #(all mines flagged && no of mines == no of flags) || all others              revealed
  end

  def lost?
    true if #last move was a mine
  end

end