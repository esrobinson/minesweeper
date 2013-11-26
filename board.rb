class Board
  attr_reader :tile_grid

  def initialize
    @tile_grid = Array.new(9) do |row|
      Array.new(9) { |col| Tile.new(self, [row, col]) }
    end
    set_bombs
  end

  def make_move(move)
    move_type, coords = move
    coords.reverse!
    move_type == "f" ? self[coords].flag : self[coords].reveal
  end

  def set_bombs(no_of_bombs = 9)
    total_bombs = 0
    until total_bombs == no_of_bombs do
      tile = @tile_grid.sample.sample
      total_bombs += 1 unless tile.bomb?
      tile.bomb = true
    end
  end

  def [](coords)
    x,y = coords
    @tile_grid[x][y]
  end

  def print
    @tile_grid.each do |row|
      puts row.join(" ")
    end
  end

  def to_s
    @tile_grid.map { |row| row.join(" ") }.join("\n")
  end

  def won?
    @tile_grid.all? do |row|
      row.all? { |tile| tile.revealed? || tile.bomb? }
    end
  end

end