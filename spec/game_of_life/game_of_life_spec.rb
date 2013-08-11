require 'rspec'
require_relative '../../lib/game_of_life'

describe GameOfLife do

  describe "initialization" do
    it "should accept width, height and seeds" do
      game = GameOfLife.new(10, 20, 5)
      game.should_not be_nil
    end

    it "should create a grid with the correct width" do
      game = GameOfLife.new(10, 20, 5)
      game.grid.width.should == 10
    end

    it "should create a grid with the correct height" do
      game = GameOfLife.new(10, 20, 5)
      game.grid.height.should == 20
    end

    it "create the correct number of seed cells" do
      game = GameOfLife.new(10, 20, 5)
      game.live_cell_count.should == 5
    end

    it "always create the correct number of seed cells" do
      game = GameOfLife.new(2, 2, 4)
      game.live_cell_count.should == 4
    end
  end

  describe "#state=" do
    it "should set the grid" do
      game = GameOfLife.new
      new_grid = [[0,0], [0,0]]
      game.state = new_grid
      game.state.should == new_grid
    end
  end


  describe "#live_cell_count" do

    it "should return the correct number of live cells" do
      game = GameOfLife.new
      game.state = [
          [0,0,0],
          [0,1,0],
          [0,0,0]
      ]
      game.live_cell_count.should == 1
    end

    it "should return the correct number of live cells 2" do
      game = GameOfLife.new
      game.state = [
          [0,1,0],
          [0,1,0],
          [0,0,0]
      ]
      game.live_cell_count.should == 2
    end

  end

  describe "#evolve" do

    it "should kill off a single life cell" do
      game = GameOfLife.new
      game.state = [
          [0,0,0],
          [0,1,0],
          [0,0,0]
      ]
      expect {
        game.evolve
      }.to change { game.live_cell_count }.by(-1)
    end

    it "should kill off a two life cells" do
      game = GameOfLife.new
      game.state = [
          [0,1,0],
          [0,1,0],
          [0,0,0]
      ]
      expect {
        game.evolve
      }.to change { game.live_cell_count }.by(-2)
    end

    it "should oscillate a line" do
      game = GameOfLife.new
      game.state = [
          [0,0,0,0,0],
          [0,0,1,0,0],
          [0,0,1,0,0],
          [0,0,1,0,0],
          [0,0,0,0,0]
      ]
      game.evolve
      game.state.should == [
          [0,0,0,0,0],
          [0,0,0,0,0],
          [0,1,1,1,0],
          [0,0,0,0,0],
          [0,0,0,0,0]
      ]
    end

  end

end

