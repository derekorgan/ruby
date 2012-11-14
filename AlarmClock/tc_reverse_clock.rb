require 'test/unit'
require 'reverse_clock.rb'

class TC_Reverse_Clock < Test::Unit::TestCase
	def setup
		@rc = ReverseClock.new 0,0,0
	end

	def test_sec
		@rc.tick
		assert_equal(@rc.sec, 59, '1 Second decrement not decrementing by 59')
		assert_equal(@rc.min, 59, '1 Second decrement not leaving min as 59')
		assert_equal(@rc.hr, 23, '1 Second decrement not leaving hr as 23')
	end
	
	def test_min
		60.times {@rc.tick}
		assert_equal(@rc.sec, 0, '60 second decrement should have 0 sec value')
		assert_equal(@rc.min, 59, '60 Second decrement not decrementing min by 59')
		assert_equal(@rc.hr, 23, '60 Second decrement not leaving hr as 23')
	end		

	def test_hr
		3600.times {@rc.tick}
		assert_equal(@rc.sec, 0, '3600 second decrement should have 0 sec value')
		assert_equal(@rc.min, 0, '3600 Second decrement should have 0 min value')
		assert_equal(@rc.hr, 23, '3600 Second decrement not decrementing hr by 23')
	end	

	def test_day
		86400.times {@rc.tick}
		assert_equal(@rc.sec, 0, '86400 second decrement should have 0 sec value')
		assert_equal(@rc.min, 0, '86400 Second decrement should have 0 min value')
		assert_equal(@rc.hr, 0, '86400 Second decrement should have 0 hr value')

	end

	def test_rand
		86410.times {@rc.tick}
		assert_equal(@rc.sec, 50, '200000 second decrement should have 50 sec value')
		assert_equal(@rc.min, 59, '200000 Second decrement should have 59 min value')
		assert_equal(@rc.hr, 23, '200000 Second decrement should have 23 hr value')

	end

end