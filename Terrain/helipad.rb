require "./terrain.rb"

class Helipad < Terrain
	attr_reader :lx,:ly, :height

	def initialize(base_terrain)
		@bt = base_terrain	
		# location of this terrain on base terrain
		@lx = @ly = @height = 0
		super 0
	end

	def set_location!
		
		largest = 0
		# create a two-d array the same size as the base terrain 
		# to store the sizes of the flat areas in the top left of the square
		sizes = TwoDArray.new(@bt.w,@bt.h) 
		sizes.fill(0)

		# set the all values for the bottom row to 1 
		(0..@bt.w-1).each do |i|
			sizes[i,@bt.h-1] = 1
		end

		# set all the values of the far right column to be 1
		(0..@bt.h-1).each do |i|
			sizes[@bt.w-1,i] = 1
		end

		# traverse the array from the bottom right to top left(backwards)
		# exclude the row and column populated above
		(@bt.h-2).downto(0) do |y|
			(@bt.w-2).downto(0) do |x|
				
				if same_values?(x,y)
					s = sizes[x,y] = sizes[x+1,y+1] + 1
					if s > largest
				 		@lx,@ly = x,y
				 		@height = @bt[x,y]
				 		largest = s
				 	elsif s == largest
				 		if @bt[x,y] > @height
				 			@lx,@ly = x,y
				 			@height = @bt[x,y]
				 		end
					end
				else
					sizes[x,y] = 1
				end

			end
		end
		# populate the terrain values for helipad
		self.clear
		@w = @h = largest
		@data = Array.new(@w){ Array.new(@h) }
		self.fill(@height)
		#puts sizes.to_s
	end

	private
	# checks the values of squares below, to the right and diagonally to see if the same as location x,y
	def same_values?(x,y)
		@bt[x,y] == @bt[x+1,y] and @bt[x,y] == @bt[x,y+1] and @bt[x,y]== @bt[x+1,y+1]
	end
end

