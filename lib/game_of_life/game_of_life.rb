class GameOfLife

  def initialize(width = 0, height = 0, seed_count = 0)
    init_grid(width, height)
    init_seeds(seed_count)
  end

  attr_reader :grid, :cells

  def state=(array)
    width = array.length
    height = array.first.length
    init_grid(width, height)

    @grid.each do |cell|
      cell.alive = array[cell.x][cell.y] == 1
    end
  end

  def state
    @grid.map do |cell|
      cell.alive ? 1 : 0
    end
  end

  def live_cell_count
    @grid.cells.select { |c| c.alive? }.length
  end

  def evolve
    @grid.each { |cell| cell.evolve }
    @grid.each { |cell| cell.apply_new_state }
  end

  private

  def init_grid(width, height)
    @grid = Grid.new(width, height) do |x, y|
      Cell.new(x, y)
    end
  end

  def init_seeds(seed_count)
    seed_count.times do
      add_seed
    end
  end

  def add_seed
    dead_cells = @grid.cells.select { |c| !c.alive? }
    cell = dead_cells[rand(dead_cells.length)]
    cell.alive = true if cell
  end

end