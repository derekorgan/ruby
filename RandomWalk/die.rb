
# Represents a 4-sided die where each side represents a compass direction
# Maintains statistics on throws so far

NUM_SIDES = 4

class Die
  # Set stats to zero for all directions
  def initialize
    @stats = {:NORTH=>0, :SOUTH=>0, :EAST=>0, :WEST=>0}
  end

  # Return one of :NORTH, :SOUTH, :EAST or :WEST
  def throw
    direction = case rand(NUM_SIDES)
      when 0: :NORTH
      when 1: :SOUTH
      when 2: :EAST
      when 3: :WEST
    end
    @stats[direction] += 1
    direction
  end
  attr_accessor :stats
end