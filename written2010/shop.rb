VAT = 20.0
DISCOUNT = 5.0

class Shop
	attr_reader :items

	def initialize
		@items = Array.new
	end

	def add(item)
		@items << item
	end

	def print
		@items.each do |x|
			puts x
		end
	end

	def total_value
		@items.inject(0){|sum, item| sum + item.real_price }
	end
end

class Item
	attr_reader :name, :price

	include Enumerable

	def initialize(name, price)
		@name, @price = name, price
	end

	def real_price
		@price * (1+VAT/100)
	end

	def to_s
		"#{@name} #{real_price}"
	end

end

class DiscountItem < Item

	def initialize(name, price, discount)
		super(name, price)
		@discount = discount
	end

	def real_price
		(@price - @discount) * (1 + VAT/100)
	end
end

s = Shop.new

f = File.new("./shop.dat")
f.each do |x|
	a = x.chomp.split(/\s+/)
	n = a[0]
	p = a[1].to_f
	i = DiscountItem.new(n,p,DISCOUNT)
	s.add(i)
end

s.print
puts s.total_value



