require "./terrain.rb"

class SwimmingPool < Terrain
	attr_reader :lx,:ly

	def initialize(n, base_terrain)
		super  0
		@bt = base_terrain	
		@n = n # width/height of the swimming pool terrain

		if (n > @bt.w)
			puts "The Pool Size is too big. It must be smaller than the base terrain"
		end
		# location of this terrain on base terrain
		@lx = @ly = 0
	end

	def set_location! 

		lowest = low_sdev = -1.0
		# we only want to tranverse to max start positions 
		# e.g. base terrain size minus size of pool
		max = @bt.w - @n
		
		temp = Terrain.new

		(0..max).each do |y|
			(0..max).each do |x|	
				
				@bt.slice_rows(x,y,@n,@n) do |row|
				    temp << row
				end

				m = temp.mean
				if m < lowest || lowest == -1
					@lx, @ly = x, y
					lowest = m
					low_sdev = temp.standard_deviation
				elsif m == lowest 
					if temp.standard_deviation < low_sdev || low_sdev == -1
						@lx, @ly = x, y
					end
				end
				temp.clear
			end
		end

		# fill swimming pool terrain with best location values from base terrain
		self.clear 
		@bt.slice_rows(@lx,@ly,@n,@n) do |row|
			self << row
		end
	end
end
