unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  $:.unshift(File.expand_path(File.dirname(__FILE__)))
end

require 'game_of_life/game_of_life'
require 'game_of_life/grid'
require 'game_of_life/cell'