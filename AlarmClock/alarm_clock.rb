require 'clock.rb'

class AlarmClock < Clock
	attr_reader :ahr, :amin, :asec, :status

	def initialize hr, min, sec, ahr, amin, asec
		super hr, min, sec
		@status = :NO_ALARM

		@ahr = Integer(ahr)
		@amin = Integer(amin)
		@asec = Integer(asec)
	end

	def tick
		super
		
		if !is_alarm?
			@status = :NO_ALARM
		end

		if is_alarm?
			@status = :ALARM
		end
	end

	def is_alarm?
		@hr == @ahr && @min == @amin && @sec == @asec
	end


end # End class AlarmClock
