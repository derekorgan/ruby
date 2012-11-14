require 'rubygems'
require 'stalker'

100.times do |i|
	Stalker.enqueue('post', :id => i)
	puts 'queued'
end


# 100 in 8 seconds with 5 workers


