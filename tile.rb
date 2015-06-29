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

  def initialize(bombed, board = [])
    @bombed = bombed
    @flagged = false
    @revealed = false
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
      real_neighbors << neighbor if neighbor.first.between?(0,@board.length - 1) && neighbor.last.between?(0,@board.length - 1)
    end

    real_neighbors
  end

  def neighbor_bomb_count

  end

  def inspect
    if !@revealed
      "*"
    elsif @flagged
      "F"
    elsif @bombed
      "X"
    elsif self.neighbor_bomb_count == 0
      "_"
    elsif self.neighbor_bomb_count > 0
      self.neighbor_bomb_count.to_s
    end
  end
end
