require 'test/unit'
require 'lighthouse_keeper.rb'

class TC_Lighthouse_Keeper < Test::Unit::TestCase
	def setup
		@light_hse_k = LightHouseKeeper.new
	end

	def test_days_on_duty

		@light_hse_k.is_Dawn
		assert_equal(@light_hse_k.days_on_duty, 1, 'Dawn did not increment days on duty by 1')
		@light_hse_k.is_Dusk
		@light_hse_k.is_Dawn
		assert_equal(@light_hse_k.days_on_duty, 2, 'Dawn did not increment days on duty by 1 from Dusk an Dawn')
		@light_hse_k.restart_duty
		assert_equal(@light_hse_k.days_on_duty , 0, 'Restart Duty didn\'t reset to 0')
	end

	def test_status
		assert_equal(@light_hse_k.status, :AWAKE, 'Did not initilize status to awake.')
		@light_hse_k.is_Dawn
		assert_equal(@light_hse_k.status, :AWAKE, 'Dawn status is not set to awake.')
		@light_hse_k.is_Dusk
		assert_equal(@light_hse_k.status, :ASLEEP, 'Dusk status is not set to asleep')
	end


end