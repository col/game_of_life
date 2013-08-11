class Grid

  def initialize(width, height, &block)
    @width, @height = width, height

    @grid = (0...width).map do |x|
      (0...height).map do |y|
        yield(x, y)
      end
    end

    @cells = @grid.inject(:+) || []
    init_neighbours
  end

  attr_reader :width, :height
  attr_reader :cells

  def map
    (0...@width).map do |x|
      (0...@height).map do |y|
        yield @grid[x][y]
      end
    end
  end

  def each
    @cells.each do |cell|
      yield cell
    end
  end

  def fetch(x, y)
    @grid[x][y]
  end

  private

  def init_neighbours
    @cells.each do |cell|
      x, y = cell.x, cell.y
      neighbours = []
      neighbours << fetch(x,north(y))
      neighbours << fetch(east(x),north(y))
      neighbours << fetch(east(x),y)
      neighbours << fetch(east(x),south(y))
      neighbours << fetch(x,south(y))
      neighbours << fetch(west(x),south(y))
      neighbours << fetch(west(x),y)
      neighbours << fetch(west(x),north(y))
      cell.neighbours = neighbours
    end
  end

  def north(y)
    (y - 1 + height) % height
  end

  def east(x)
    (x + 1) % width
  end

  def south(y)
    (y + 1) % height
  end

  def west(x)
    (x - 1 + width) % width
  end

end