# Incoming Query Messages
class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  # Incoming Query message: changes nothing but does a calculation and returns a result
  # Test Incoming Query messages by making assertions about what they send back
  def diameter
    rim + (tire * 2)
  end
end