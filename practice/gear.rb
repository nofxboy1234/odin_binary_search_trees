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

  # Incoming Query message: changes nothing (no side effects) but does a calculation and returns a result.
  # Test Incoming Query messages by making assertions about what they send back.
  # Test the interface, not the implementation.
  # If I test only the interface, it means I can change the implementation,
  # without breaking the test.
  def gear_inches
    ratio * wheel.diameter
  end

  # This is a Query/Command combo
  # It returns the result - Query part
  # Incoming Command message: It sets this value so that when
  # other people send :cog later, they see a different thing.
  # Test the Command part of this.
  def set_cog(new_cog)
    @cog = new_cog
  end

  private

  def ratio
    chainring / cog.to_f
  end
end