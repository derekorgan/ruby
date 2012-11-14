require 'test/unit'
require './terrain.rb'

class TC_Terrain < Test::Unit::TestCase
	def setup
		lines = Array.new
		lines[0] = "10"
		lines[1] = "1 1 3 4 5 6 7 8 9 10"
		lines[2] = "1 2 3 4 5 6 7 8 9 10"
		lines[3] = "1 2 3 4 5 6 7 8 9 10"
		lines[4] = "1 2 3 4 5 6 7 8 9 10"
		lines[5] = "1 2 3 4 5 6 7 8 9 10"
		lines[6] = "1 2 3 4 5 6 7 8 9 10"
		lines[7] = "1 2 3 4 5 6 7 8 9 10"
		lines[8] = "1 2 3 4 5 6 7 12 12 12"
		lines[9] = "1 2 3 4 5 6 7 12 12 12"
		lines[10] =	"1 2 3 4 5 6 7 12 12 12"

		@t = Terrain.new
		# push rows to the terrain
		1.upto(10).each do |i|
	 		@t << lines[i].split(' ').map(&:to_i)
		end
	end

	def test_highest_point
		h = @t.highest_point
		assert_equal('7,7', h , "highest point should be 7,7")
	end

end
