class Game

  def initialize
    @board = nil
  end

  def play
    @board = Board.new

    until @board.won? || @board.lost?
      move = get_move
      @board.make_move(move)
    end

  end

  def get_move
    @board.print
    puts "Choose flag or reveal: "
    move_type = gets.chomp
    puts "Choose a square: "
    coords = gets.chomp
    move = coords.split(",").map (&:to_i)
    [move_type, move]
  end



end