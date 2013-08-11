require 'rubygame'
include Rubygame

class CellSprite

  include Sprites::Sprite

  attr_accessor :cell

  def initialize(position, size, cell)
    super()
    @cell = cell
    @image = Surface.new size
    @image.set_colorkey [0,0,0]
    @rect = Rect.new position, size
    @colour = [255, 255, 255]

    # Draw the cell (a circle will do for now)
    center = size.map { |x| x/2 }
    @image.draw_circle_s center, center[0]-0.1, @colour
    @image.set_alpha 0,0
  end

  def draw(screen)
    if cell.alive?
      super
    end
  end

end