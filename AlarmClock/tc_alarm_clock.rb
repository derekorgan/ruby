require 'test/unit'
require 'alarm_clock.rb'

class TC_Alarm_Clock < Test::Unit::TestCase
	def setup
		@ac = AlarmClock.new 0,0,0,0,1,0
	end

	def test_init
		assert_equal(@ac.ahr, 0, 'Alarm Hr is not initiated correctly')
		assert_equal(@ac.amin, 1, 'Alarm Min is not initiated correctly')
		assert_equal(@ac.asec, 0, 'Alarm Sec is not initaited correctly')
		assert_equal(@ac.status, :NO_ALARM, 'The status should be :NO_ALARM')

	end

	def test_alarm
		60.times { @ac.tick }
		assert(@ac.is_alarm?, '0:1:0 should trigger the alarm')
		assert_equal(@ac.status, :ALARM, 'The status should be :ALARM')
		10.times { @ac.tick }
		assert(!@ac.is_alarm?, '0:1:10 should not trigger an alarm')
		assert_equal(@ac.status, :NO_ALARM, 'The status should be :NO_ALARM')
		
	end


end