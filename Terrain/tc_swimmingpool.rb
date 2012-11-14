require 'test/unit'
require './swimming_pool.rb'

class TC_SwimmingPool < Test::Unit::TestCase
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

		@sp = SwimmingPool.new(2,@t)
	end

	def test_set_location
		@sp.set_location!

		assert_equal(0, @sp.lx+@sp.ly, "Location of the pool should be 0,0")
		
		@t[0,0] = 9

		@sp.set_location!
		assert_equal(0, @sp.lx, "Location of the pool should be 0,1")
		assert_equal(1, @sp.ly, "Location of the pool should be 0,1")

		# create 2x2 block with the same mean but higher standard deviation
		@t[5,4] = 1
		@t[5,5] = 1
		@t[6,4] = 1
		@t[6,5] = 3
		@sp.set_location!
		assert_equal(0, @sp.lx, "Location of the pool should be 0,1")
		assert_equal(1, @sp.ly, "Location of the pool should be 0,1")

	end


end