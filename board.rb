class Board
  attr_reader :tile_grid

  def initialize
    @tile_grid = Array.new(9) do |row|
      Array.new(9) { |col| Tile.new(self, [row, col]) }
    end
    set_bombs
    set_neighbor_bombs
  end

  def set_neighbor_bombs
    @tile_grid.each_with_index do |row, r_index|
      row.each_with_index do |tile, c_index|
        tile.neighbor_bombs = neighbor_bombs(tile)
      end
    end
  end

  def make_move(move)
    move_type, coords = move
    coords.reverse!
    move_type == "f" ? flag(coords) : reveal_contig(coords)
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

  def reveal_contig(coords)
    reveal_queue = [self[coords]]
    until reveal_queue.empty?
      current_tile = reveal_queue.shift
      current_tile.reveal
      return false if current_tile.bomb?
      if current_tile.neighbor_bombs == 0
        current_tile.adjacent_tiles.each do |tile|
          reveal_queue << tile unless tile.revealed?
        end
      end
    end
    true
  end

  def flag(coords)
    self[coords].flag
  end

  def neighbor_bombs(tile)
    tile.adjacent_tiles.count do |tile|
      tile.bomb?
    end
  end
end