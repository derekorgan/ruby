
require 'die.rb'
require 'grid.rb'
require 'kangaroo.rb'

class RandomWalk
  def initialize dimension
    grid = Grid.new dimension
    @skippy = Kangaroo.new grid
  end

  def start
    while !@skippy.at_home?
      @skippy.hop!
    end
  end

  def stats
    @skippy.die_stats
  end

  def num_of_hops
    @skippy.num_of_hops
  end

  def locations_visited
    @skippy.locations_visited
  end
end

# Get grid dimension from user
puts "Enter dimension of the Grid (>=1):"
while((dimension = gets.to_i) < 1) do
   puts "Dimension must be greater than 0. Please enter dimension of the Grid:"
end

# Create and start simulation
rw = RandomWalk.new dimension
rw.start

# Print points visited by kangaroo
puts "Points kangaroo visits from initial location to home:"
rw.locations_visited.each do |point|
  puts point.to_s
end

# Print die stats
total_throws = 0
rw.stats.each do |direction, num_of_throws|
  total_throws += num_of_throws
end
puts "Total number of hops the kangaroo took: #{rw.num_of_hops}"
puts "Die stats are as follows:"
[:NORTH, :SOUTH, :EAST, :WEST].each do |direction|
  percentage = (total_throws!=0) ? (rw.stats[direction].fdiv(total_throws)*100).round : 0
  puts "#{direction}: #{percentage}%"
end
