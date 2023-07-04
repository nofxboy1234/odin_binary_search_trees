require 'pry-byebug'

# syntactic sugar
p 1.to_s
# sends the symbol, that invokes the method named in the symbol
p 1.send(:to_s)
puts "\n"

# syntactic sugar
p 1 + 1
p 1.send(:+, 1)
puts "\n"

p 1.class
p Integer.instance_methods(false)
puts "\n"

p 1 == 1
p 1.send(:==, 1)
puts "\n"

p true.class
p TrueClass.instance_methods(false)
puts "\n"

p false.class
p FalseClass.instance_methods(false)
puts "\n"

# 'if' is special syntax for dealing with Booleans
if 1 == 1
  p 'is true'
else
  p 'is false'
end

if true
  p 'is true'
else
  p 'is false'
end
puts "\n"

# if truthy
#   p 'is true'
# else
#   p 'is false'
# end
# puts "\n"

# type check
# if some_object_whose_type_i_know
#   p 'is true'
# else
#   p 'is false'
# end
# puts "\n"

# 'Message sending' syntax for TrueClass/FalseClass
# class TrueClass
#   def if_true
#     yield
#     self
#   end

#   def if_false
#     self
#   end
# end

class FalseClass
  def if_true
    self
  end

  def if_false
    yield
    self
  end
end

# (1 == 1).if_true { puts 'evaluated block' }
# (true).if_true { puts 'evaluated block' }
# (1 == 1).if_false { puts 'evaluated block' }
# (true).if_false { puts 'evaluated block' }

# (1 == 2).if_true { puts 'evaluated block' }
# (false).if_true { puts 'evaluated block' }
# (1 == 2).if_false { puts 'evaluated block' }
# (false).if_false { puts 'evaluated block' }
# puts "\n"

# 'Message sending' syntax for truthy/falsey
class Object
  def if_true
    yield
    self
  end

  def if_false
    self
  end
end

class NilClass
  def if_true
    self
  end

  def if_false
    yield
    self
  end
end

# Everything is true
# nil and false are false
'anything'.if_true { puts 'evaluated block' }
'anything'.if_false { puts 'evaluated block' }

nil.if_true { puts 'evaluated block' }
nil.if_false { puts 'evaluated block' }
puts "\n"

if 1 == 1
  p 'is true'
else
  p 'is false'
end

# return self so the new methods added to Object, FalseClass and NilClass
# can be chained together.
(1 == 1)
  .if_true { p 'is true' }
  .if_false { p 'is false' }
puts "\n"

if 1 == 2
  p 'is true'
else
  p 'is false'
end

(1 == 2)
  .if_true { p 'is true' }
  .if_false { p 'is false' }
puts "\n"

if nil
  p 'is true'
else
  p 'is false'
end

nil
  .if_true { p 'is true' }
  .if_false { p 'is false' }
puts "\n"

# What if there were no 'if'?
class Animal
  @animals = []

  def self.animals
    @animals
  end

  def self.add(animal)
    animals.push(animal)
  end

  # factory method
  def self.find(id)
    animals.find { |element| element.name == id }
  end

  def initialize(name)
    @name = name
    self.class.add(self)
  end

  def name
    @name
  end
end

Animal.new('pig')
Animal.new('cat')
Animal.new('sheep')

p Animal.animals

# binding.pry
p Animal.find('pig')
p Animal.find('')

puts "\n"

ids = ['pig', '', 'sheep']
animals = ids.map { |id| Animal.find(id) }
p animals
puts "\n"

# sometimes nil is nothing
# animals.compact!

# animals.each { |animal| puts animal.name }

# animals.each do |animal| 
#   puts animal.nil? ? 'no animal' : animal.name
# end

# animals.each do |animal| 
#   puts animal && animal.name
# end

# animals.each do |animal| 
#   puts animal == nil ? '' : animal.name
# end

# animals.each do |animal| 
#   puts animal.is_a?(NilClass) ? '' : animal.name
# end

# animals.each do |animal| 
#   if animal.is_a?(NilClass)
#     puts ''
#   else
#     puts animal.name
#   end
# end

animals.each do |animal| 
  if animal.is_a?(NilClass)
    puts 'no animal'
  else
    puts animal.name
  end
end

# type check
# if some_object_whose_type_i_know
#   I'll supply the behaviour
# else
#   I'll send a message
# end
# puts "\n"

# If you send it a message, nil is something

# Null Object Pattern - Active Nothing
class MissingAnimal
  def name
    'no animal'
  end
end

# Prefer knowing an object to duplicating behaviour
ids = ['pig', '', 'sheep']
# || MissingAnimal.new: 
#   Still have conditional
#   Added dependency but no longer own the behaviour
animals = ids.map { |id| Animal.find(id) || MissingAnimal.new }
p animals
animals.each { |animal| puts animal.name }
puts "\n"

# Prefer knowing few objects
# Take that untrustworthy external API and wrap it in your own object
# You can catch that message and forward it on
# You can put the condition in one place
class GuaranteedAnimal
  def self.find(id)
    Animal.find(id) || MissingAnimal.new
  end
end

# Call your own trustworthy API
animals = ids.map { |id| GuaranteedAnimal.find(id) }
p animals
# Talk to all the objects like they're the same thing
animals.each { |animal| puts animal.name }
puts "\n"
puts "\n"

# Null Object Pattern is a small concrete instance of a much larger abstraction
class House
  def recite
    (1..data.length).map { |i| line(i) }.join("\n")
  end
  
  def line(number)
    "This is #{phrase(number)}.\n"
  end
  
  def phrase(number)
    # data.last(number).join(' ')
    parts(number).join(' ')
  end

  def parts(number)
    data.last(number)
  end
  
  def data
    (1..12).to_a
  end
end

puts House.new.line(1)
puts House.new.line(2)
puts House.new.line(3)
puts "\n"
puts House.new.recite
puts "\n"
puts "\n"

# New feature request: RandomHouse
# Task: Implement RandomHouse without 'if' statements

# Inheritance?
class RandomHouse < House
  def data
    @data ||= super.shuffle
  end
end

random_house = RandomHouse.new
puts random_house.line(1)
puts random_house.line(12)
puts "\n"
puts "\n"

# New feature request: EchoHouse
# Task: Implement EchoHouse without 'if' statements

# Inheritance?
class EchoHouse < House
  def parts(number)
    super.zip(super).flatten
  end
end

puts EchoHouse.new.line(1)
puts EchoHouse.new.line(12)
puts "\n"
puts "\n"

# New feature request: EchoHouse
# Task: Implement EchoHouse without 'if' statements

# Can inherit RandomHouse#data, and duplicate EchoHouse#parts
class RandomEchoHouse < RandomHouse
  def parts(number)
    super.zip(super).flatten
  end
end
# or
# Can inherit EchoHouse#parts, and duplicate RandomHouse#data
# class RandomEchoHouse < EchoHouse
#   def data
#     @data ||= super.shuffle
#   end
# end
# or
# Duplicate EchoHouse#parts, and duplicate RandomHouse#data
# class RandomEchoHouse < House
#   def data
#     @data ||= super.shuffle
#   end

#   def parts(number)
#     super.zip(super).flatten
#   end
# end

# Inheritance if for specialization, not for sharing code

# What does RandomHouse change?
# Reveal how things differ, by making them more alike
class House
  def recite
    (1..data.length).map { |i| line(i) }.join("\n")
  end
  
  def line(number)
    "This is #{phrase(number)}.\n"
  end
  
  def phrase(number)
    # data.last(number).join(' ')
    parts(number).join(' ')
  end

  def parts(number)
    data.last(number)
  end
  
  def data
    (1..12).to_a
  end
end

class RandomHouse < House
  def data
    @data ||= super.shuffle
  end
end

# Make House#data more like RandomHouse#data
class House
  DATA = (1..12).to_a

  def recite
    (1..data.length).map { |i| line(i) }.join("\n")
  end
  
  def line(number)
    "This is #{phrase(number)}.\n"
  end
  
  def phrase(number)
    # data.last(number).join(' ')
    parts(number).join(' ')
  end

  def parts(number)
    data.last(number)
  end

  def data
    @data ||= DATA
  end
end

class RandomHouse < House
  def data
    @data ||= DATA.shuffle
  end
end

# What does RandomHouse change? - Name the concept
# | class       | data |   ???   |
# --------------------------------
# | House       | DATA |         |
# | RandomHouse | DATA | shuffle |

# | class       | data |   order |
# --------------------------------
# | House       | DATA |         |
# | RandomHouse | DATA | shuffle |
# Orderer is a role
class DefaultOrder
  def order(data)
    data
  end
end

class RandomOrder
  def order(data)
    data.shuffle
  end
end