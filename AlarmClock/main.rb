require 'clock.rb'
require 'alarm_clock.rb'
require 'reverse_clock.rb'
require 'datafile.rb'

dat = DataFile.new "clock.dat"
if dat.read_file?
	input = dat.get_content

	puts "** Clock **"
	c = Clock.new(input[0], input[1], input[2])
	puts c
	200000.times {c.tick}
	puts c
	puts

	puts "** Alarm Clock **"
	ac = AlarmClock.new(input[0], input[1], input[2],input[3], input[4], input[5])
	puts ac
	200000.times {
		ac.tick
		if ac.status == :ALARM
			puts "Alarm! #{ac}"
		end
	}
	puts ac
	puts

	puts "** Reverse Clock **"
	rc = ReverseClock.new(input[0], input[1], input[2])
	puts rc
	200000.times {rc.tick}
	puts rc

end
