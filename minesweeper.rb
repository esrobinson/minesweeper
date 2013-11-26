require_relative 'board'
require_relative 'tile'
require_relative 'leaderboard'
require 'yaml'

class Game
  attr_reader :board

  def initialize
    @board = nil
    @leader_board = LeaderBoard.load
  end

  def play
    lost = false
    until @board.won? || lost
      puts @board.to_s
      move = get_move
      lost = !@board.make_move(move)
    end
    end_of_game
    start

  end

  def end_of_game
    puts @board
    time = (Time.now - @start_time).round(1)
    if @board.won?
      puts "You won in #{time} seconds"
      puts "Please enter your name for the leader board: "
      name = gets.chomp
      leader = Leader.new(name, time)
      @leader_board.add_leader(leader)
      @leader_board.save
    else
      puts "You lose in #{time} seconds"
    end
    @leader_board.print_best
  end

  def start
    puts "Choose (n)ew game or (l)oad game? "
    game_type = gets.chomp.downcase[0]
    if game_type == "n"
      @start_time = Time.now
      @board = Board.new
    else
      load_game
    end
    play
  end


  def load_game
    puts "Please enter file name: "
    file_name = gets.chomp
    game_state = YAML.load(File.read(file_name))
    @board = game_state[:board]
    @start_time = Time.now - game_state[:elapsed_time]
  end


  def get_move
    puts "Choose (f)lag, (r)eveal or (s)ave: "
    move_type = gets.chomp.downcase[0]
    if move_type == "s"
      puts "Please enter File Name: "
      file_name = gets.chomp
      save_game(file_name)
      return get_move
    end
    puts "Choose a square: "
    coords = gets.chomp
    move = coords.split(",").map(&:to_i)
    [move_type, move]
  end

  def save_game(filename)
    elapsed_time = Time.now - @start_time
    File.open(filename, "w") do |f|
      f.puts ({board: @board, elapsed_time: elapsed_time}.to_yaml)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.start
end