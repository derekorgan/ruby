# I've extended the enumberable module to include some statistics on data sets
# e.g. Mean, Variance, Standard Deviation, Sum

module Enumerable

	def sum
		self.inject(0){|acc,i|acc +i}
	end

	def mean
		self.sum/self.size.to_f
	end

	def variance
		m = self.mean
		sum=self.inject(0){|acc,i|acc +(i-m)**2}
		1/self.size.to_f * sum
	end

	def standard_deviation
		Math.sqrt(self.variance)
	end
end