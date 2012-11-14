require 'datafile.rb'

class Clock
	attr_reader :hr, :min, :sec

	def initialize hr, min, sec
		@hr = Integer(hr)
		@min = Integer(min)
		@sec = Integer(sec)

		if !valid_hr? || !valid_min? || !valid_sec?
			raise "Invalid time, hr, min and sec must be within valid ranges e.g. 0..23 or 0..59.  Time set to 0:0:0"
			@hr, @min ,@sec = 0, 0, 0
		end
	end

	# increment time by 1 second on 24hr clock
	def tick
		if @sec < 59
			@sec += 1
		else
			@sec = 0
			if min < 59
				@min += 1
			else
				@min = 0
				if @hr < 23
					@hr += 1
				else
					@hr = 0
				end
			end
		end
	end

	def to_s
		"#{@hr}:#{@min}:#{@sec}"
	end

	private
	def valid_hr?
		@hr.between?(0,23)
	end

	def valid_min?
		@min.between?(0,59)
	end

	def valid_sec?
		@sec.between?(0,59)
	end
end # End class Clock


