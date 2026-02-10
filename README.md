# Power::Emitter

# Emitter

A lightweight Ruby event emitter that allows you to bind, emit, and stop custom events using blocks.

## Features

- Bind callbacks to custom event names
- Emit events with arguments
- Stop listening to specific or all events

## API

`bind(event, &block)`
Registers a block (callback) to an event.

`emit(event, *args)`
Calls all callbacks for the given event, passing in arguments.

`stop(*events)`
- If called with arguments, stops those specific events.
- If called without arguments, clears all listeners.

## Usage
```ruby
emitter = Emittable::Emitter.new

# Bind a listener
emitter.bind(:greet) { |name| puts "Hello, #{name}!" }

# Emit an event
emitter.emit(:greet, "World")  # => prints "Hello, World!"

# Stop a specific event
emitter.stop(:greet)

# Stop all events
emitter.stop
```


## Example with Emittable

```ruby
class Chat
  include Emittable
  #include Emittable::Aliases

  def initialize
    @messages = []
  end

  def add_message(msg)
    emit :new_message, msg
    @messages << msg
  end

  def clear!
    emit :clear_messages, @messages
    @messages.clear
  end
end

chat = Chat.new
chat.bind(:new_message) { |msg| puts "New Message: #{msg}" }
chat.bind(:clear_messages) { |msgs| puts "#{msgs.count} Messages deleted!" }
```

The Chat class includes Emittable, a mixin that adds event-driven capabilities by creating a private emitter instance method.
Internally, it uses Ruby’s Forwardable module to delegate bind, emit, and stop calls directly to the underlying Emitter instance.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
