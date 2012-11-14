# A TwoDArray is a Two-Dimensional Array of a consistent width
class TwoDArray

	attr_reader :w, :h

	include Enumerable
	include Comparable 


	def initialize (w=0, h=0)
		if w > 0 and h > 0
			@data = Array.new(w){ Array.new(h) }
		else
			@data = Array.new{ Array.new }
		end

		@w = w
		@h = h
	end

	# getter
	def [](x, y)
		@data[y][x]
	end

	# setter
	def []=(x,y,val)
		@data[y][x] = val
	end

	# allows you to push an array/row to the 2 demensional array.
	# all rows must be the same width
	def << (val)
		# if this is first row set the width based on size of first array to be pushed
		if @h == 0 
			@w = val.size
		elsif val.size != @w or val.class.to_s != 'Array'
			raise "Only add rows/arrays the same size as the width(#{@w})"
		end	

		@data[@h] = val
		@h += 1
	end

	def <=> (other)
		self.size <=> other.size
	end

	def map 
		temp = TwoDArray.new(@w,@h)
		@data.each_index do |y|
			@data[y].each_index do |x|
				temp[x,y] = yield self[x,y]
			end
		end 
	end

	def map! 
		@data.each_index do |y|
			@data[y].each_index do |x|
				self[x,y] = yield self[x,y]
			end
		end 
	end

	def each 
		@data.each do |y|
			y.each do |x|
				yield x
			end
		end 
	end
	# this returns a hash of x,y
	def each_index
		@data.each_index do |y|
			@data[y].each_index do |x|
				yield x, y
			end
		end 
	end

	# this returns a hash of x,y,value
	def each_with_index
		@data.each_index do |y|
			@data[y].each_with_index do |val, x|
				yield x,y,val
			end
		end

	end


	# yeilds each row of the slice from position x,y of width w and height h
	def slice_rows(x,y,w,h)
		(y..y+h-1).each do |i|
			yield @data[i][x..x+w-1]
		end
	end

	def max
		to_ary.max
	end

	# simplified version of fill that only takes one argument
	def fill(x)
		@data.each do |a|
			a.fill x
		end
	end

	def clear
		@data.clear
		@w = @h = 0
	end

	#returns the product of width and height
	def size
		@w * @h
	end

	# return flattened 1 demensional array of data
	def to_ary
		@data.flatten
	end

	def to_s
		s = ""
		@data.each do |y|
			s += y.join(' ') + "\n"
		end

		s
	end
end
