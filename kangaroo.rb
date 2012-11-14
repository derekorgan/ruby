class Die
  def initialize
      @mystats = {:NORTH => 0, :SOUTH => 0, :EAST => 0, :WEST => 0 }  
  end
      
  #return one of :NORTH :SOUTH :EAST, :WEST with equal probablity
  def throw
    r = rand(4)
    
    if r == 0
      @mystats[:NORTH] += 1
      @thisthrow = ":NORTH"
    elsif r == 1
      @mystats[:SOUTH] += 1
      @thisthrow = ":SOUTH"
    elsif r == 2
      @mystats[:EAST] += 1
      @thisthrow = ":EAST"
    else
      @mystats[:WEST] += 1
      @thisthrow = ":WEST"
    end
    
  end

  # return hash table describing stats of throws so far  e.g. {:NORTH=> 35, SOUTH:=>42, EAST=>}
  def stats
    @mystats
  end
  
end

class Point
  attr_reader :x, :y
  
  def initialize x, y
    @x = x
    @y = y
  end
  
  def move! direction, i
    case direction
    when ":NORTH"
      @x += i
    when ":SOUTH"
      @x -= i    
    when ":EAST"
      @y += i
    when ":WEST"
      @y -= i
    end

  end
  

  
end

class Kangaroo
  
  def initialize dimension
    @dimension = dimension
    @p = Point.new 0,0
    @d = Die.new
    
  end
  
  #take a random hop in one direction
  def hop!
   direction = @d.throw
   
   # If at the boundary we want don't want to hop in certain directions.
   if at_boundary?
     while (@notx == direction || @noty == direction)
        direction = @d.throw 
        #puts "notx: #{@notx} noty #{@noty}"
     end
      
   end
   @notx = ""
   @noty = ""
   @p.move! direction, 1
   puts "#{direction} : #{@p.x}, #{@p.y}"
  end
  
  # return true if at at boundary of space
  def at_boundary?
    b = false
    if @p.x == 0 
      @notx = ":SOUTH"
      b = true 
    end
    if @p.x == @dimension - 1
      @notx = ":NORTH"
      b =  true
    end  
    if @p.y == 0 
      @noty = ":WEST"
      b = true
    end
    if @p.y == @dimension - 1
      @noty = ":EAST"
      b = true
    end
    
    return b
  end
  
  # return true if at home
  def at_home?
    if @p.x == @dimension-1 && @p.y == @dimension-1
      true
    else
      false
    end
    
  end
  
  # return current location (a point)
  def location
    @p
  end

  
end

class RandomWalk < Kangaroo
  
  
  def initialize dimension
    super dimension
    @hops = 0

  end
  
  # start the simulation
  def start! 
    while (!at_home?)
      hop!
      @hops += 1
    end
    
  end
  
  # return final location of the kangaroo
  def final_location
    "#{@p.x}, #{@p.y}"
  end
  
  # return number of hops the kangaroo took durning the simulation
  def no_of_hops
    @hops
  end
  
  # return hash table describing die stats
  def stats
    @d.stats
  end
  
end



rw = RandomWalk.new 10
rw.start!
puts "Final Location: " + rw.final_location
puts "Number of Hops: #{rw.no_of_hops}"
p rw.stats


