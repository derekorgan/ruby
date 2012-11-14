INITIAL_MATCHES = 21

class Nim 
  attr_accessor :remaining_matches
  
  def initialize
    @remaining_matches = INITIAL_MATCHES
  end
  
  def take_matches num_of_matches
    @remaining_matches -= num_of_matches
  end
  
  def play_computer_move
      take_matches 1
  end
  
  def game_over?
    @remaining_matches <= 1
  end
end

my_nim = Nim.new

while !my_nim.game_over? do
  puts 'enter num of matches to take' 
  num_to_take = gets.to_i
  my_nim.take_matches num_to_take
  puts my_nim.remaining_matches 
  my_nim.play_computer_move
  puts my_nim.remaining_matches
end

