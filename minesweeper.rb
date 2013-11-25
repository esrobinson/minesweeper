require_relative 'board'
require_relative 'tile'
require 'yaml'

class Game

  attr_reader :board

  def initialize
    @board = nil
  end

  def play
    lost = false
    until @board.won? || lost
      move = get_move
      lost = !@board.make_move(move)
    end
    puts "You win" if @board.won?
    puts "You lose" if lost
  end

  def start
    puts "Choose (n)ew game or (l)oad game? "
    game_type = gets.chomp.downcase[0]
    if game_type == "n"
      @board = Board.new
    else
      puts "Please enter file name: "
      file_name = gets.chomp
      @board = YAML.load(File.read(file_name))
    end
    play
  end

  def get_move
    @board.print
    puts "Choose (f)lag, (r)eveal or (s)ave: "
    move_type = gets.chomp.downcase[0]
    if move_type == "s"
      puts "Please enter File Name: "
      file_name = gets.chomp
      save_game(file_name)
      get_move
    end
      puts "Choose a square: "
      coords = gets.chomp
      move = coords.split(",").map(&:to_i)
    [move_type, move]
  end

  def save_game(filename)
    File.open(filename, "w") do |f|
      f.puts @board.to_yaml
    end
  end



end