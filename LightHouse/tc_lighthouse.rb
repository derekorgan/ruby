require 'test/unit'
require 'lighthouse.rb'

class TC_Lighthouse < Test::Unit::TestCase
	def setup
		@light_hse = LightHouse.new
	end
	def test_initialize
		assert(@light_hse.on_or_off? == :OFF, 'New Light House not Off')
	end

	def test_button
		@light_hse.press_button
		assert(@light_hse.on_or_off? == :ON, "Press button didn't change it to On")
		@light_hse.press_button
		assert(@light_hse.on_or_off? == :OFF, "Press button didn't change back to Off ") 
	end

	

end

