class Gear
  attr_reader :chainring, :cog, :wheel, :observer

  def initialize(chainring:, cog:, wheel:, observer:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
    @observer = observer
  end

  # Sends a private message to itself (ration)
  # Sends a message to a collaborating object (wheel.diameter) -> Wheel
  #   Do not test Outgoing Query messages (wheel.diameter) (just like messages sent to self)
  #     Do not make assertions about their result
  #     Do not expect to send them

  # Messages sent to self and Outgoing Query messages
  # both have no Visible side-effects.

  # Notes to self: 
  #   I think Visible side-effects = Direct Public side-effects
  #   I think Command messages sent to self can have Visible side effects, but the methods
  #   that cause the side-effects will have their own tests, if public.

  # From the sending side, if you're sending a message that does not have Visible side effects,
  # it is invisible to the rest of your app.
  # The sender should not test it.

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
    changed
    @cog
  end

  # changed method has an Outgoing Command message (observer.changed)
  # #changed message must get sent to observer, otherwise the app will not be correct.
  # observer.change creates side-effects upon which others depend.

  # If you make assertions about what happens when an Outgoing Command message
  # is sent, it creates a dependency between you and every object and message
  # between you and that distant side-effect.
  # The distant side-effect is not Gear's responsibility - it should not even
  # know that is what's happening - Reaching across a bunch of intermediate objects
  # and testing a distant side-effect, is an Integration Test.

  # The test for observer.changed does not depend on all the objects
  # and messages between you and the distant side-effect.
  # The test depends on the message (interface)
  # It tests the thing for which Gear is responsible.
  # Gear is responsible for sending #changed to observer.
  # It tests at the nearest edge (API).

  # Code that can tolerate change, couples to stability.
  # Testing in this way, places a bet, that the API (the nearest edge),
  # that message that you're sending, is more stable than the distant
  # side-effect and the path to it.

  # Outgoing Command message: Expect to send
  # Caveat: Sometimes the side-effect is cheap and close (stable and cheap) 
  # - if it is, just plug in the object.
  def changed
    observer.changed(chainring, cog)
  end

  private

  # From sighting along the edges of space capsule POV:
  # As far as the rest of your app is concerned, this method does not exist.
  # If a method in your public interface (#gear_inches) calls this, if the test for that public
  # method is correct, the this #ratio method is correct.

  # Do not test private messages (don't get bound to implementation):
  #   Do not make assertions about their result
  #   Do not expect to send them

  # Caveat: Break private test rule if it saves $$$$ during development
  # You can test private methods e.g. you're TDD'ing a complex private algorithm, but
  # delete them afterwards, otherwise it can make people hesitant to change and improve
  # your private code, because they don't want to deal with those private tests.
  
  # Do not test messages (Query/Command) (public/private) sent to self (don't get bound to implementation):
  #   Do not make assertions about their result
  #   Do not expect to send them

  def ratio
    chainring / cog.to_f
  end
end