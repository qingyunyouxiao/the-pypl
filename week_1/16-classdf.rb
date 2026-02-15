class Person
  def initialize(name, age)
  @name = name
  @age = age
  end

  def greet
    puts "Hello, my name is #{@name} and I am #{@age} years old."
  end

  def celebrate_birthday
    @age += 1
    puts "Happy birthday, #{@name}! You are now #{@age} years old."
  end
end
