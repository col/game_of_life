class Cell

  def initialize(x, y)
    @x, @y = x, y
    @alive = false
    @neighbours = []
  end

  attr_reader :x, :y
  attr_accessor :alive
  attr_accessor :neighbours

  def evolve
    @new_state = nil
    if should_die?
      @new_state = false
    elsif should_be_born?
      @new_state = true
    end
  end

  def apply_new_state
    @alive = @new_state unless @new_state.nil?
  end

  def alive?
    @alive
  end

  def to_s
    "#{@x}, #{@y} - #{@alive}"
  end

  def ==(cell2)
    self.to_s == cell2.to_s
  end

  private

  def live_neighbours
    @neighbours.select { |cell| cell.alive? }.length
  end

  def should_die?
    alive? && live_neighbours < 2 || live_neighbours > 3
  end

  def should_be_born?
    !alive? && live_neighbours == 3
  end

end