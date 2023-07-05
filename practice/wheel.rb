# Incoming Query Messages
class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  # Incoming Query message: changes nothing (no side effects) but does a calculation and returns a result.
  # Test Incoming Query messages by making assertions about what they send back.
  # Test the interface, not the implementation.
  # If I test only the interface, it means I can change the implementation,
  # without breaking the test.
  def diameter
    rim + (tire * 2)
  end
end