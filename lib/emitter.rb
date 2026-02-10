# frozen_string_literal: true
module Emittable
  require "forwardable"
  extend Forwardable

  def_delegators :emitter, :bind, :emit, :stop

  private

  def emitter
    @emitter ||= Emittable::Emitter.new
  end

  class Emitter
    def initialize
      @listeners = Hash.new { |h,k| h[k] = [] }
    end

    def bind(event, &block)
      @listeners[event] << block
    end

    def emit(event, *args)
      @listeners[event].map { it.call(*args) }
    end

    def stop(*events)
      return @listeners.clear if events.empty?
      events.each { @listeners.delete it }
    end
  end

  module Aliases
    BIND = %i[ on subscribe listen observe handle ].freeze
    EMIT = %i[ fire publish broadcast notify trigger ].freeze
    STOP = %i[ off unsubscribe drop ignore release ].freeze

    def self.included(base)
      BIND.each { base.alias_method it, :bind }
      EMIT.each { base.alias_method it, :emit }
      STOP.each { base.alias_method it, :stop }
    end
  end
end
