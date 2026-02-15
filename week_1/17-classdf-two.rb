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

  # Getter method for name
  def name
    @name
  end

  # Setter method for name
  def name=(new_name)
    @name = new_name
  end

  # Getter method for age
  def age
    @age
  end

  # Setter method for age
  def age=(new_age)
    @age = new_age
  end
end

person1 = Person.new("Alice", 30)
person1.greet

person1.name = "Bob"
person1.age = 25
person1.greet

person1.celebrate_birthday