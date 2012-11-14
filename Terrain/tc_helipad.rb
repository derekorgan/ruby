require 'test/unit'
require './helipad.rb'

class TC_Helipad < Test::Unit::TestCase
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

		@hp = Helipad.new(@t)
	end

	def test_set_location
		@hp.set_location!

		assert_equal(7, @hp.lx, "Location of the pool should be 7,7")
		assert_equal(7, @hp.ly, "Location of the pool should be 7,7")

		@t[5,4] = 15
		@t[5,5] = 15
		@t[5,6] = 15
		@t[6,4] = 15
		@t[6,5] = 15
		@t[6,6] = 15		
		@t[7,4] = 15
		@t[7,5] = 15
		@t[7,6] = 15	
		@hp.set_location!

		assert_equal(5, @hp.lx, "Location of the pool should be 5,4")
		assert_equal(4, @hp.ly, "Location of the pool should be 5,4")
			
	end

end