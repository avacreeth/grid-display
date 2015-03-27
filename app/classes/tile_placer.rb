
class TilePlacer

  class Tile

    attr_accessor :id, :sizex, :sizey, :posx, :posy, :size

    def initialize(id, sizex, sizey, posx, posy, size)
      @id = id
      @sizex = sizex
      @sizey = sizey
      @posx = posx
      @posy = posy
      @size = size
    end

    def get_area
      x_edge = (posx...(posx + sizex)).to_a
      y_edge = (posy...(posy + sizey)).to_a
      x_edge.product(y_edge)
    end
  end

  attr_reader :x, :y, :grid

  # Dimensions of grid
  def initialize(x, y, grid = nil)
    @x = x || grid[:dim_x]
    @y = y || grid[:dim_y]
    @grid = grid || Hash.new
    @grid[:dim_x] = @x
    @grid[:dim_y] = @y
    @grid[:tiles] ||= []
  end

  # Returns true if the specified tile fits at
  # the tested position.
  def fits?(tile)
    # Check out of bounds
    if ((tile.posx + tile.sizex - 1) > x) || ((tile.posy + tile.sizey - 1) > y)
      return false
    end

    area = tile.get_area

    area.all? { |pos| grid[pos].nil? }
  end

  # Adds the specified tile
  def add(tile)
    if fits?(tile)
      area = tile.get_area
      area.each { |pos| grid[pos] = tile.id }
      grid[:tiles] << tile
      grid
    else
      false
    end
  end

  def remove(tile)
    area = tile.get_area
    area.each { |pos| grid[pos] = nil }
    grid[:tiles].delete(tile)
    grid
  end

end
