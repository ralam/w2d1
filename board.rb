require_relative 'tile'
require 'byebug'

class Board

  attr_reader :board

  def initialize
    @board = populate
  end

  def populate # so we know the size of the board we're populating
    grid = Array.new(9) {Array.new (9)}
    bomb_count = 9
    size = grid.length
    bomb_list = bomb_pos(bomb_count, size)
    grid.each_with_index do |row, r_idx|
      row.each_with_index do |cell, c_idx|
        row[c_idx] = Tile.new(bomb_list.include?([r_idx, c_idx]), self)
      end
    end
  end

  def bomb_pos(count, size)
    pos = []
    until pos.length == count
      cell = [rand(size), rand(size)]
      pos << cell unless pos.include? cell
    end
    pos
  end

  def show_board
    @board.each_with_index do |row, r_idx|
      r = []
      row.each_with_index do |tile, c_idx|
        r << tile.inspect
      end
      p r
    end
  end

  def find_me(tile)
    @board.each_with_index do |row, r_idx|
      row.each_with_index do |cell, c_idx|
        return [r_idx, c_idx] if cell == tile
      end
    end
  end

  def []=(pos, mark)
    row, col = pos.first, pos.last
    @board[row][col] = mark
  end

end

game = Board.new
game.show_board
