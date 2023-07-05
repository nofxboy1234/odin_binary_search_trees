# Incoming Query Messages
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  # Sends a private message to itself (ration)
  # Sends a message to a collaborating object (wheel.diameter) -> Wheel

  # Incoming Query message: changes nothing (no side effects) but does a calculation and returns a result
  # Test Incoming Query messages by making assertions about what they send back
  def gear_inches
    ratio * wheel.diameter
  end

  private

  def ratio
    chainring / cog.to_f
  end
end