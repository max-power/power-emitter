# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "emitter"
require "tldr/autorun"

class TestEmitter < TLDR
  def setup
    @emitter = Emittable::Emitter.new
  end

  def test_bind_and_emit
    result = []
    @emitter.bind(:greet) { |name| result << "Hello, #{name}" }
    @emitter.emit(:greet, "Ruby")
    assert_equal ["Hello, Ruby"], result
  end

  def test_multiple_bindings
    results = []
    @emitter.bind(:ping) { results << "one" }
    @emitter.bind(:ping) { results << "two" }
    @emitter.emit(:ping)
    assert_equal ["one", "two"], results
  end


  def test_emit_with_arguments
    results = []
    @emitter.bind(:add) { |a, b| results << (a + b) }
    @emitter.emit(:add, 2, 3)
    assert_equal [5], results
  end

  def test_stop_specific_event
    result = []
    @emitter.bind(:foo) { result << 1 }
    @emitter.stop(:foo)
    @emitter.emit(:foo)
    assert_equal [], result
  end

  def test_stop_multiple_events
    @emitter.bind(:a) { :x }
    @emitter.bind(:b) { :y }
    @emitter.stop(:a, :b)
    assert_equal [], @emitter.emit(:a)
    assert_equal [], @emitter.emit(:b)
  end

  def test_stop_all
    @emitter.bind(:a) { :x }
    @emitter.bind(:b) { :y }
    @emitter.stop
    assert_equal [], @emitter.emit(:a)
    assert_equal [], @emitter.emit(:b)
  end
end
