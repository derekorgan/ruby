class Pet
  def daily_routine
    puts "I am a #{self.class}"
    eat
    3.times { speak }
   
    sleep
    puts " "
  end
  
  def eat
    puts "I eat Meat"
  end

end
 
class Mouse < Pet
  def speak
    puts "Squeak!"
  end

  def sleep
    puts "I sleep in my hole"
  end
end

class Gerbil < Pet
  def speak
    puts "Squeak!"
  end

  def sleep
    puts "I sleep in my cage"
  end
end
 

class Cat < Pet
  def speak
    puts 'Meow!'
  end

  def sleep
    puts "I sleep on my mat"
  end
end

class Dog < Pet
  def speak
    puts 'Woof!'
  end

  def sleep
    puts "I sleep in my kennel"
  end
end

class PetLover
  def initialize 
    
    @mypets = Array.new(10)
    
    @mypets.each_index do |i| 
    
      r = rand(4)
      
      case r
        when 0
          @mypets[i] = Dog.new
        when 1
          @mypets[i] = Cat.new
        when 2
          @mypets[i] = Mouse.new
        when 3
          @mypets[i] = Gerbil.new
      end

    end #mypets.each
  end #initialize
  
  def shout
  
      @mypets.each do |i|
          i.daily_routine
      end

  end
end

p = PetLover.new
p.shout


  

