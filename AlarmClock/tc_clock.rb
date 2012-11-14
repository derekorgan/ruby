require 'test/unit'
require 'clock.rb'

class TC_Clock < Test::Unit::TestCase
	def setup
		@c = Clock.new 0,0,0
	end

	def test_init
		assert_equal(@c.hr, 0, 'Hr is not initiated correctly')
		assert_equal(@c.min, 0, 'Min is not initiated correctly')
		assert_equal(@c.sec, 0, 'Sec is not initaited correctly')
	end

	def test_sec
		@c.tick
		assert_equal(@c.sec, 1, '1 Second increment not incrementing by 1')
		assert_equal(@c.min, 0, '1 Second increment not leaving min as 0')
		assert_equal(@c.hr, 0, '1 Second increment not leaving hr as 0')
	end
	
	def test_min
		60.times {@c.tick}
		assert_equal(@c.sec, 0, '60 second increment should have 0 sec value')
		assert_equal(@c.min, 1, '60 Second increment not incrementing min by 1')
		assert_equal(@c.hr, 0, '60 Second increment not leaving hr as 0')
	end		

	def test_hr
		3600.times {@c.tick}
		assert_equal(@c.sec, 0, '3600 second increment should have 0 sec value')
		assert_equal(@c.min, 0, '3600 Second increment should have 0 min value')
		assert_equal(@c.hr, 1, '3600 Second increment not incrementing hr by 1')
	end	

	def test_day
		86400.times {@c.tick}
		assert_equal(@c.sec, 0, '86400 second increment should have 0 sec value')
		assert_equal(@c.min, 0, '86400 Second increment should have 0 min value')
		assert_equal(@c.hr, 0, '86400 Second increment should have 0 hr value')

	end

	def test_rand
		200000.times {@c.tick}
		assert_equal(@c.sec, 20, '200000 second increment should have 20 sec value')
		assert_equal(@c.min, 33, '200000 Second increment should have 33 min value')
		assert_equal(@c.hr, 7, '200000 Second increment should have 7 hr value')

	end


end
