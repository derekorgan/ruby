
# Represents a square grid

class Grid
  # Create grid of given dimension
  def initialize dimension
    @lower_left = Point.new 0,0
    @upper_right = Point.new dimension-1, dimension-1
  end

  # Return true iff the given point lies outside the grid
  def lies_outside? point
    if point.x < @lower_left.x || point.x > @upper_right.x || \
       point.y < @lower_left.y || point.y > @upper_right.y then
      true
    else
      false

    end
  end

  # Return the upper right most point on the grid
  def home
    @upper_right
  end
end