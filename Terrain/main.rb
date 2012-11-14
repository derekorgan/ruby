require "./datafile.rb"
require "./terrain.rb"
require "./swimming_pool.rb"
require "./helipad.rb"

# 1) Read File
file = DataFile.new('./terrain.dat', 'r')
lines = Array.new

file.read_file {|x| lines << x}

size = lines[0].to_i
pool_size = lines[size+1].to_i

# 2) Setup Terrain
t = Terrain.new
# push rows to the terrain
(1..size).each do |i|
	 t << lines[i].split(' ').map(&:to_i)
end

# 3) Get Stats 
puts "Highest Point:       #{t.highest_point}"
puts "Mean:                #{t.mean}"
puts "Standard Deviation:  #{t.standard_deviation}"

# 4) Create Swimming pool & find best location
if (pool_size > 0)
	sp = SwimmingPool.new(pool_size, t)
	sp.set_location!
	puts "Swimming Pool:       #{sp.lx},#{sp.ly}"
end

# 5) Create Helipad & Find best location
hp = Helipad.new(t)
hp.set_location!
puts "Helipad Location:    #{hp.lx},#{hp.ly}"
puts "Helipad Height:      #{hp.height}"
puts "Helipad Width:       #{hp.w}"
