#### Terrain Analyzer             ####
#### Comp 30070                   ####
#### Object Oriented Programming  ####
#### John Mark Swafford           ####

# Module for array math/manipulation
module Array_Ops

  # Get the standard deviation of the heights
  def std_height matrix, size=matrix.length
    sum_sqrs = 0
    matrix.each do |row|
      row.each { |elm| sum_sqrs += elm**2 }
    end
    Math.sqrt((sum_sqrs.to_f / size**2) - (mean_matrix(matrix)**2))
  end # of std_heights

  # Get the sub-matrix  
  def get_sub_matrix matrix, x, y, size
    new_mat = []
    (y..y+size).each { |row| new_mat << matrix[row][x..x+size] }
    new_mat
  end # of get_sub_matrix

  # Convert a matrix to a 1D array
  def matrix_to_array matrix
    arr = []
    matrix.each { |row| arr += row }
    arr
  end  

  # Is a matrix flat?
  def is_flat? matrix
    std_height(matrix) == 0
  end

  # Method for getting the mean of an array
  def mean vals
    vals.inject{ |sum, el| sum + el }.to_f / vals.size    
  end

  # Get the average depth of the heights
  def mean_matrix matrix
    mean matrix_to_array matrix
  end
end

# Point class
class Point
  attr_accessor :x, :y, :height
  def initialize x=0, y=0, height=0
    @x, @y, @height = x, y, height
  end

  def to_s
    "(#{@x}, #{@y}) -- #{@height}"
  end

  def == point
    @x == point.x && @y == point.y
  end

end # of point class

# Pool class for storing Pool information (I didn't get to using this
# class)
class Pool 
  attr_accessor :pnt, :size, :mean, :std_dev  

  def initialize pnt, size, mean, std_dev
    @pnt, @size, @mean, std_dev = pnt, size, mean, std_dev
  end

  def to_s 
    "Location: #{@pnt} -- Size: #{@size} -- Mean: #{@mean} -- Std. Dev. #{@std_dev}"
  end
end # of pool class


# Plateau class for storing the location, size and height of plateaus
class Plateau
  attr_reader :pnt, :size, :height
  def initialize pnt, size, height
    @pnt, @size, @height = pnt, size, height
  end

  def to_s 
    "Location: #{pnt} -- Size: #{size} -- Height: #{height}"
  end
end # of plateau class

class Terrain
  include Array_Ops
  attr_reader :heights, :size
  
  def initialize terrain_file
    @size, @heights = load_terrain terrain_file
  end # of initialize

  # Find and return the index of the highest point in the terrain
  def highest_point
    max_pnt = Point.new 0, 0, @heights[0][0]

    @heights.each_index do |row_ind|
      @heights.each_index do |col_ind|
        if(@heights[row_ind][col_ind] >= max_pnt.height)
          max_pnt = Point.new col_ind, row_ind, @heights[row_ind][col_ind]
        end
      end
    end
    max_pnt
  end # of highest_point

  # Find the lowest avg. height for a square of size pool_size (use
  # pool class - not done)
  def site_pool height_sqr, pool_size=2
    
    memo_map = {}
    size_max = height_sqr.length-pool_size-1
    
    (0..size_max).each do |row_ind|
      row_arr = row_ind..(row_ind+pool_size - 1)

      (0..size_max).each do |col_ind|

        # Get data for the pool size
        mini_mat = get_sub_matrix height_sqr, row_ind, col_ind, pool_size-1

        # Save the array, mean, and std. dev. in a map
        if not memo_map.has_key? matrix_to_array mini_mat
          memo_map[matrix_to_array mini_mat] = [Point.new(row_ind, col_ind, height_sqr[row_ind][col_ind]), mean_matrix(mini_mat), std_height(mini_mat)]
        end

      end
    end # of looping

    # Get the best pool out of the map
    pool_best = memo_map.values[0]
    memo_map.values.each do |val|
      if val[1] < pool_best[1]
        pool_best = val
      elsif val[1] == pool_best[1]
        if val[2] < pool_best[2]
          pool_best = val
        end
      end
    end

    pool_best[0]
  end # of site_pool

  # Find the best grid for the helicopter
  def site_choppa matrix, size=matrix.length
    find_plateaus matrix
  end # of site_choppa

  private

  def find_plateaus matrix
    best_plateau = nil
    
    for row in 0..matrix.length-2

      for col in 0..(matrix[row].length)-2
        height = matrix[row][col]
        size = 1

        # 1. Get the sub-matrix
        sub_mat = get_sub_matrix matrix, col, row, size
        is_level = is_flat? sub_mat

        # 2. Is it flat?
        while is_level
          if size == 1
            new_plat = Plateau.new(Point.new(col,row,height), size+1, height)
            best_plateau = check_best_plateau best_plateau, new_plat
          end
        
          if row+size+1 <= matrix.length-1 and col+size+1 <= matrix.length-1
            size += 1
            sub_mat = get_sub_matrix matrix, col, row, size
            is_level = is_flat? sub_mat
          end

          # 3. Is it the best plateau so far?
          if is_level
            new_plat = Plateau.new(Point.new(col,row,height), size+1, height)
            best_plateau = check_best_plateau best_plateau, new_plat
          end

          # Break the while loop
          if row+size == matrix.length-1 or col+size == matrix.length-1
            break
          end
        end
      end
    end
    best_plateau
  end

  # Check and update the best plateau (could go in the plateau class)
  def check_best_plateau old_best, new_plat
    if old_best == nil
      return new_plat
    end

    if old_best.size < new_plat.size
      return new_plat
    elsif old_best.size == new_plat.size
      if old_best.height < new_plat.height
        return new_plat
      end
    end

    old_best
  end

  # Get the size and heights of the terrain
  def load_terrain file
    heights = []
    File.new(file, 'r').each { |line| heights << line.split.map{ |s| s.to_i } }
    size = heights.delete_at(0)[0] 
    return size, heights
  end # of load_terrain

end # of Terrain class

if __FILE__ == $0

  ter = Terrain.new 'terrain_mel.dat'
  puts "\n----- Part 1 -----"
  puts "Highest point is: #{ter.highest_point}"
  puts "Mean height is: #{ter.mean_matrix ter.heights}"
  puts "Std. Dev. of heights is: #{ter.std_height ter.heights}" 
  
  puts "\n----- Part 2 -----"
  puts "Best location for the pool: #{ter.site_pool ter.heights, 4}"

  puts "\n----- Part 3 -----"
  puts "Best location for the choppa: #{ter.site_choppa ter.heights}"
end # of main
