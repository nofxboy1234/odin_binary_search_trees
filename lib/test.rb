require 'pry-byebug'
require './lib/byebug_syntax_highlighting'

class Cat
  attr_accessor :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Dog
  attr_accessor :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

# binding.pry
byebug
kitten = Cat.new('Whiskey', 1)
puppy = Dog.new('Pluto', 1)

dylan = 19

while kitten.age < 99
  dylan += 1
  kitten.age += 1
  puppy.age += 1
end

puts 'end'
