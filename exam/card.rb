HAND_SIZE = 5

class Card 
	attr_accessor :suit, :kind, :suits, :kinds

	def initialize k, s
		@suit = s
		@kind = k
		@suits = Array.[](:diamond, :heart, :club, :spade)
		@kinds = Array.[](:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king)
	
	end


	def set k,s
		@suit = s
		@kind = k

	end

	def set_random
		@kind = @kinds[rand(@kinds.size-1)]
		@suit = @suits[rand(@suits.size-1)] 
	end

	def equals other
		self.suit == other.suit and self.kind == other.kind
	end

	def same_kind other
		self.kind == other.kind
	end

		

	def to_s
		"#{@kind.to_s.upcase} of #{@suit.to_s.upcase}S"

	end

end


class Pack
	attr_reader :cards


	def initialize 

		@cards = Array.new

		temp = Card.new :ace, :heart

		temp.suits.each do |s|
			temp.kinds.each do |k|
				c = Card.new k,s
				self.add c
			end
		end


	end

	def add card
	 	@cards << card
	end

	def remove c
		@cards.each_index do |i|
			if c.equals(@cards[i])
				@cards.delete_at(i)
			end
		end
	end

	def pick_random
		i = rand(@cards.size)
		c = @cards[i]
		self.remove @cards[i]
		c
	end

	def deal_hand
		h = Hand.new 

		0.upto(HAND_SIZE-1) do |i|
			h.add self.pick_random
		end
		h
	end
end

class Hand
	attr_reader :cards, :size

	include Comparable 


	def initialize 
		@cards = Array.new
	end

	def <=> (other)
		rank <=> other.rank
	end

	def add card
	 	@cards << card
	end



	def rank
		numkinds = {:ace => 0, :two => 0, :three => 0, :four => 0, :five => 0, :six => 0, :seven => 0, :eight => 0, :nine => 0, :ten => 0, :jack => 0, :queen => 0, :king => 0}
			
		(0..@cards.size-1).each do |i|
			numkinds[@cards[i].kind] += 1
		end
		h =0
		numkinds.each do |key, value|
			if (value>h)
				h=value
			end
		end
		@size = h-1
		h-1
	end


	def to_s
		@cards.join(', ')
	end

end

# Part 1 
n = 0
c = Card.new :queen, :spade 

while c.suit != :heart or c.kind != :jack 
	c.set_random
	n+=1
end

puts "Found JACK of HEARTS after #{n} attempts"

# Part 2
p = Pack.new

found = false
m = 0
while !found
	x = p.pick_random
	y = p.pick_random
	z = p.pick_random

	if x.same_kind(y) and y.same_kind(z)
		found = true
	else
		p.add x
		p.add y
		p.add z
	end
	m+=1
end

puts "\nFound three #{x.kind.to_s.upcase}S after #{m} attempts"
puts x
puts y
puts z



#Part 3
hands = Array.new(4)
puts "\n4 Hands: "

hands.each_index do |i|
	 hands[i] = p.deal_hand
end
hands.sort!.reverse!

puts hands







