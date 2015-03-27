
class GridPlanner

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def size_map
    {
      large: {
        'text' => {
          x: 8,
          y: 1
        },
        'image' => {
          x: 3,
          y: 3
        },
        'youtube' => {
          x: 3,
          y: 3
        }
      },
      medium: {
        'text' => {
          x: 4,
          y: 1
        },
        'image' => {
          x: 2,
          y: 2
        },
        'youtube' => {
          x: 2,
          y: 2
        }
      },
      small: {
        'text' => {
          x: 1,
          y: 1
        },
        'image' => {
          x: 1,
          y: 1
        },
        'youtube' => {
          x: 1,
          y: 1
        }
      }
    }
  end

  def size_schedule
    [:large, :large, :medium, :medium, :medium, :medium, :small, :small, :small, :small, :small, :small]
  end

  def plan(tiles)
    i = 0
    placer_tiles = tiles.map do |tile|
      size = size_map[size_schedule[i]][tile.content_type]
      placer_tile = TilePlacer::Tile.new(tile.id, size[:x], size[:y], 1, 1, size_schedule[i])

      i += 1

      placer_tile
    end

    puts "PLACER TILES"
    puts placer_tiles.inspect

    placer = TilePlacer.new(x, y)

    plan_for_grid(placer_tiles, placer)
  end

  def plan_for_grid(placer_tiles, placer)
    positions = (1..x).to_a.product((1..y).to_a)

    if placer_tiles.empty?
      return placer
    end

    tile = placer_tiles.first

    positions.each do |pos|
      tile.posx = pos[0]
      tile.posy = pos[1]
      new_placer = TilePlacer.new(x, y, placer.grid.dup)

      if new_placer.fits?(tile)
        new_placer.add(tile)
        plan = plan_for_grid(placer_tiles.drop(1), new_placer)
        return plan if plan.present?
      end
    end

    return nil
  end

end
