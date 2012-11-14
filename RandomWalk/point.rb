
# Represents a 2-D point. The point can be moved, or the previous move undone.

class Point
  def initialize(x,y)
    @x, @y = x,y
    @old_x, @old_y = x,y
  end

  # Move point and remember its previous position
  def move direction
    @old_x, @old_y = @x,@y
    case direction
      when :NORTH: @y+=1
      when :SOUTH: @y-=1
      when :EAST:  @x+=1
      when :WEST:  @x-=1
    end
  end

  # Restore point to its previous position
  def undo
    @x = @old_x
    @y = @old_y
  end

  # Return true iff point is at same location as the given point
  def == other_point
    @x == other_point.x && @y == other_point.y

  end

  # Return this point as a string
  def to_s
    "(#{@x}, #{@y})"
  end

  attr_reader :x, :y
end