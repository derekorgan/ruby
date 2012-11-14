class DataFile 
	attr_reader :file_read

	# the initializer takes in the file name 
	def initialize myfile
		@file_read = false # can we read the file and is it in the expected format
		@dat_file = myfile

		if (!@file_read = read_file?)
			puts "'#{@dat_file}' has invalid input. It must have integers seperated by new line chars."
		end
	end

	# read in the files to @lines array
	def read_file?

		@lines = Array.new 
		i = 0
		begin	
			file = File.new(@dat_file, 'r')
			
			while line = file.gets
				@lines[i] = line.strip # remove newline char
				i = i+1
			end

			file.close
		rescue => err
			puts "Exception " + err
			err
			exit
		end

		if is_valid_input?	
			true
		else
			false
		end
	end

	def get_content
		@lines
	end

	private
	# tests to see if all lines have possitive integers
	def is_valid_input?

		@lines.each do |i|
			if !numeric?(i)
				return false
			end
		end 
	end # is_valid_input?

	# tests the object is number or more specfically that it is an Integer
	def numeric?(object)
 		true if Integer(object) rescue false
 	end
end



