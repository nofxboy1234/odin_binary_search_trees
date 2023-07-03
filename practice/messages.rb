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
    @animals.push(animal)
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
Animal.new('dog')

p Animal.animals

# binding.pry
animal = Animal.find('pig')
p animal