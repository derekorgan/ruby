class DataFile < File 

	def initilize myfile, mod
		super myfile, mod
	end

	def read_file
		begin	
			while line = gets
				yield line.chomp 
			end
			close
		rescue => err
			puts "Exception " + err
			err
		end
	end
	
end
