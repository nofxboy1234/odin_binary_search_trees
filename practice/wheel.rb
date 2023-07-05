# Unit Tests: Goals
#   - Thorough: Prove logically and completely that the single object under test
#              is behaving correctly.
#   - Stable: We don't want tests to break when changing an implementatin detail.
#   - Fast
#   - Few: We want the code that we write for tests to be the most parsimonious
#          expression of the proofs.

# They narrow the focus down until the entire universe is a single object.
# That object is all the unit test knows about.

# Unit tests prove that every cell behaves correctly.
# Integration tests prove that the beast is alive.

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