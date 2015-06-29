class Tile
  DIRECTIONS = [
    [0, -1],
    [0, 1],
    [1, 0],
    [-1, 0],
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]

  attr_reader :bombed

  def initialize(bombed, board = [])
    @bombed = bombed
    @flagged = false
    @revealed = true
    @board = board
  end

  def reveal
    @revealed = true
  end

  def neighbors
    real_neighbors = []
    tile_pos = @board.find_me(self) # [row, col]

    DIRECTIONS.each do |pos|
      neighbor = [pos.first + tile_pos.first, pos.last + tile_pos.last]
      real_neighbors << neighbor if neighbor.first.between?(0,@board.board.length - 1) && neighbor.last.between?(0,@board.board.length - 1)
    end
    real_neighbors
  end

  def neighbor_bomb_count
    count = 0
    self.neighbors.each do |pos_pair|
      tile = @board.board[pos_pair.first][pos_pair.last]
      # debugger if tile.bombed
      count += 1 if tile.bombed
    end
    count
  end

  def inspect
    count = self.neighbor_bomb_count
    if !@revealed
      "*"
    elsif @flagged
      "F"
    elsif @bombed
      "X"
    elsif count > 0
      count.to_s
    else
      "_"
    end
  end
end
