require_relative 'board'
require "byebug"

class Game

  def initialize
    @game = Board.new
  end

  def run
    until over?
      @game.show_board
      take_turn
    end
    @game.show_board
  end

  def over?
    @game.bomb_list.each do |coords|
      tile = @game.board[coords.first][coords.last]
      return true if tile.revealed
    end

    non_bomb_list = []
    (0...9).each do |x|
      (0...9).each do |y|
        non_bomb_list << [x, y]
      end
    end


    non_bomb_list.reject! {|coordinates| @game.bomb_list.include?(coordinates)}
    # array of all coordinates, then reject bomb_list coordinates

    non_bomb_list.all? do |coords|
      # byebug
      tile = @game.board[coords.first][coords.last]
      true if tile.revealed
    end

    false
  end

  def take_turn
    puts "Enter coordinates:"
    coordinates = gets.chomp.split(" ") # str of coordinates and F/R
    puts "Enter either F for Flag or R for Reveal:"
    action = gets.chomp
    tile = @game.board[coordinates.first.to_i][coordinates.last.to_i]
    tile.flag if action == "F"
    tile.reveal if action == "R"
  end
end

game = Game.new
game.run
