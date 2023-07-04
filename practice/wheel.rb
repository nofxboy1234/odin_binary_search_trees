# Incoming Query Messages
class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  # incoming query: changes nothing but does a calculation and returns a result
  def diameter
    rim + (tire * 2)
  end
end