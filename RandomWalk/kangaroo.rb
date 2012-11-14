
# Represent a Kangaroo in a random walk simulation

require 'die.rb'
require 'point.rb'
require 'grid.rb'

class Kangaroo
  def initialize  grid
    @location = Point.new(0,0)
    @grid = grid
    @die = Die.new
    @num_of_hops = 0
    @locations_visited = [@location.clone]
  end

  # Hop to new location inside the grid
  def hop!
    @location.move(@die.throw)
    while @grid.lies_outside?(@location) do
      @location.undo
      @location.move(@die.throw)
    end
    @num_of_hops += 1
    @locations_visited.push @location.clone
  end

  # Return true iff kangaroo is at home
  def at_home?
    @location == @grid.home
  end
  
  # Return stats of the kangaroo's die
  def die_stats
    @die.stats
  end
  
  attr_reader :locations_visited, :num_of_hops
end

