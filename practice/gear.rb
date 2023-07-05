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
  #   Do not test Outgoing Query messages (wheel.diameter) (just like messages sent to self)
  #     Do not make assertions about their result
  #     Do not expect to send them

  # Messages sent to self and Outgoing Query messages
  # have no visible side-effects

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
  # Test Incoming Command messages by making assertions about Direct Public side-effects.
  # Direct: it's the responsibility of the Last ruby class involved.

  # Receiver of incoming message
  # has sole responsibility
  # for asserting
  # - the result
  # - Direct Public side-effects
  def set_cog(new_cog)
    @cog = new_cog
  end

  private

  # From sighting along the edges of space capsule POV:
  # As far as the rest of your app is concerned, this method does not exist.
  # If a method in your public interface (#gear_inches) calls this, if the test for that public
  # method is correct, the this #ratio method is correct.

  # Do not test private messages:
  #   Do not make assertions about their result
  #   Do not expect to send them

  # Caveat: Break private test rule if it saves $$$$ during development
  # You can test private methods e.g. you're TDD'ing a complex private algorithm, but
  # delete them afterwards, otherwise it can make people hesitant to change and improve
  # your private code, because they don't want to deal with those private tests.
  
  # Do not test messages (Query/Command) (public/private) sent to self:
  #   Do not make assertions about their result
  #   Do not expect to send them

  def ratio
    chainring / cog.to_f
  end
end