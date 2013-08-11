require 'rubygems'
require 'rubygame'
require 'rubygame/ftor'
require_relative './cell_sprite'
require_relative '../lib/game_of_life'

include Rubygame
include Rubygame::Sprites
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

class GameOfLiveApp

  include EventHandler::HasEventHandler

  attr_reader :cell_sprites

  def initialize()
    @screen = Rubygame::Screen.new [600,600], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @screen.title = "Game Of Life"

    @clock = Rubygame::Clock.new
    @clock.target_framerate = 3
    @clock.calibrate
    @clock.enable_tick_events

    @queue = Rubygame::EventQueue.new
    @queue.enable_new_style_events
    # Don't care about mouse movement, so let's ignore it.
    @queue.ignore = [MouseMoved]

    hooks = {
        :escape => :quit,
        :q => :quit,
        QuitRequested => :quit,
        ClockTicked => :update
    }
    make_magic_hooks( hooks )

    grid_width = 100
    grid_height = 100
    @game_of_life = GameOfLife.new(grid_width, grid_height, 900)

    cell_width = @screen.w / grid_width
    cell_height = @screen.h / grid_height

    # Create a sprite for each cell
    @cell_sprites = Group.new
    @game_of_life.grid.each do |cell|
      pos_x = cell_width * cell.x
      pos_y = cell_height * cell.y
      @cell_sprites << CellSprite.new([pos_x, pos_y], [cell_width, cell_height], cell)
    end

  end

  def run
    catch(:quit) do
      loop do
        handle_events
        draw
        # Tick the clock and add the TickEvent to the queue.
        @queue << @clock.tick
      end
    end
  end

  def handle_events
    # Fetch input events, etc. from SDL, and add them to the queue.
    @queue.fetch_sdl_events

    # Process all the events on the queue.
    @queue.each do |event|
      handle( event )
    end
  end

  def update(event)
    @game_of_life.evolve
  end

  def draw
    # Clear the screen.
    @screen.fill( :black )

    # Draw game objects
    @cell_sprites.draw @screen

    # Update screen
    @screen.update
  end

  # Quit the game
  def quit
    puts "Quitting!"
    throw :quit
  end

end