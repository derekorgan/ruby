require 'clock.rb'

class ReverseClock < Clock

	def initialize hr, min, sec
		super hr, min, sec
	end

	# decrement time by 1 second on 24hr clock
	def tick
		if @sec > 0
			@sec -= 1
		else
			@sec = 59
			if min > 0
				@min -= 1
			else
				@min = 59
				if @hr > 0
					@hr -= 1
				else
					@hr = 23
				end
			end
		end
	end

end
