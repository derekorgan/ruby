class Greeter
  
  attr_accessor :name  
  
  def initialize name, last
    @name = name
    @last = last
  end 
  
  def say_hi
    puts "Hello " + @name
  end
  
  def say_bye
    puts "Bye #{@name} #{@last}" 
  end
  
  def myrange(age)
    @age = age
    if !(0..150).include? age 
      puts "Invalid Age!"
    end
  end
  
  def is_old?
    @age > 70
  end
  
  def testit
      
      
      
  end 
  
end

my_greeter = Greeter.new "Derek","Organ"
my_greeter.say_hi
my_greeter.say_bye
my_greeter.myrange(50)
if my_greeter.is_old?
  puts my_greeter.name + " is old!"
else
  puts my_greeter.name + " is a young guy!"
end


  

