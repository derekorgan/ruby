require 'test/unit'
require './twodarray.rb'

class TC_TwoDArray < Test::Unit::TestCase
	def setup

		@x = [1,2,3]
		@y = [4,5,6]
		@z = [7,8,9]

		@a = TwoDArray.new(3,3)
		@b = TwoDArray.new
	end

	def test_setter_getter
		@x.each_index do |i|
			@a[i,0] = @x[i]
		end

		assert_equal(1, @a[0,0], "First value should be 1")
		assert_equal(3, @a[2,0], "Third value should be 3")

		@y.each_index do |i|
			@a[i,1] = @y[i]
		end
		@z.each_index do |i|
			@a[i,2] = @z[i]
		end

		assert_equal(5, @a[1,1], "1,1 value should be 5")
		assert_equal(9, @a[2,2], "2,2 value should be 9")
		assert_equal(9, @a.size, "The Size should be 9")

	end

	def test_push
		@b << @x
		assert_equal(1, @b[0,0], "First value should be 1")
		assert_equal(3, @b[2,0], "Third value should be 3")
		@b << @y
		@b << @z
		assert_equal(5, @b[1,1], "1,1 value should be 5")
		assert_equal(9, @b[2,2], "2,2 value should be 9")
		assert_equal(9, @b.size, "The Size should be 9")
	end

	def test_comparable
		@b << @x
		@b << @y

		assert_equal(true, @a > @b, "The size of 'a' (9) should be bigger than 'b' (6)")
	end

	def test_map!
		@b << @x
		@b << @y
		@b << @z

		# replace with x * x
		@b.map! do |x|
			x = x * x
		end
				
		assert_equal(25, @b[1,1], "1,1 value should be 5")
		assert_equal(81, @b[2,2], "2,2 value should be 9")
	end

	def test_clear
		@b << @x
		@b << @y
		@b << @z

		@b.clear

		assert_equal(0, @b.size, "Size should be 0")

		@b << @x
		assert_equal(3, @b.size, "Size should be 3")
		assert_equal(2, @b[1,0], "Value at 1,0 should be 2")
	end

	def test_slice_rows
		@b << @x
		@b << @y
		@b << @z

		temp = TwoDArray.new
		@b.slice_rows(1,1,2,2) do |row|
			temp << row
		end

		assert_equal(4, temp.size, "The size of the slice array should be 4 (2*2)")
		assert_equal(6, temp[1,0], "Value at 1,0 should be 6 of temp 2d array")
		assert_equal(9, temp[1,1], "Value at 1,1 should be 9 of temp 2d array")
				
	end



end
