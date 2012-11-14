class Terrain
	attr_reader :size

	def initialize(size)
		@size = size
		# create a starting terrain with all heights of 0
		@matrix = Array.new(size){ Array.new(size).map(&:to_i) }
		@cx = @cy = 0
	end

	# takes an array of strings with heights sperated by space.  
	# the first line holds the size so skip
	def populate(lines)
		i = 1
		@matrix.each_index do |x|
			# split each line into an array of integers and map to a 2 dimensional array
			@matrix[x] = lines[i].split(' ').map(&:to_i)
			i+=1	
		end	
	end

	def highest_point
		highest = 0
		hx = 0
		hy = 0

		@matrix.each_index do |y|
			@matrix[y].each_index do |x|
				if @matrix[y][x] > highest
					highest = @matrix[y][x] 
					hx = x
					hy = y
				end
			end
		end
		"#{hx},#{hy}"
	end

	def mean
		total, sum = @size*@size, 0.0
		@matrix.each { |x| sum += x.inject(:+) }
		sum/total
	end

	def s_dev
		m = mean
		total, sum = @size*@size, 0.0
		@matrix.flatten.each { |x| sum += (x-m)**2 } 	
		Math.sqrt(sum/total)
	end

	# yeilds all elements froms x,y location of size
	def get_block(size, x, y)
		(y..y+size-1).each do |i|
			(x..x+size-1).each do |j|
				yield @matrix[i][j]
			end
		end	
	end

	# it returns the size of the block.
	def get_flat_block(x,y)
		flat  = true
		h = @matrix[x][y]
		n = 1
		puts "height: #{h}"
		while x+n < @size
			puts ""
			puts "n: #{n}"
			(x..x+n).each do |i|
				puts ""
				puts "i: #{i}"
				puts "@matrix[x+n][i]: #{x+n},#{i} #{@matrix[x+n][i]}"
				puts "@matrix[i][y+n]: #{i},#{y+n} #{@matrix[i][y+n]}"
				if @matrix[x+n][i] != h || @matrix[i][y+n] !=  h
					puts "blah @matrix[x+n][i]: #{x+n},#{i} #{@matrix[x+n][i]}"
					puts "blah @matrix[i][y+n]: #{i},#{y+n} #{@matrix[i][y+n]}"	
					return n
				end
			end
			n+=1
			puts ""
			puts "#{x+n} < #{@size}"
		end
		return n
	end
	
	def to_s
		s = ""
		@matrix.each do |y|
			s += y.join(' ') + "\n"
		end 
		s
	end 

	private
	def push value
		@matrix[@cx][@cy] = value
		if (@cx < @size-1)
			@cx += 1
		else
			@cx = 0
			@cy +=1
		end
	end

	def reset
		@cx = @cy = 0
	end
end