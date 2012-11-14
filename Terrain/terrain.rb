require "./twodarray.rb"
require "./mod_enumerable.rb" # extended Enumberable Module

class Terrain < TwoDArray
	include Enumerable
	
	def initialize(n = 0)
		if (n > 0)
			super n, n
		else
			super
		end
	end

	def highest_point
		highest = hx = hy = 0
		
		self.each_with_index do |x, y, val|
			if val > highest
				highest = val
				hx, hy = x,y
			end
		end
		"#{hx},#{hy}"
	end


end