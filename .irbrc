# frozen_string_literal: true

require 'awesome_print'
require 'irb/completion'
require 'irbtools/configure'
require 'time_difference'

START = Time.now

Irbtools.welcome_message = nil
Irbtools.start

at_exit do
  session_time = TimeDifference.between(START, Time.now).humanize
  puts session_time
end

def docs(search)
  system format('ri %s', Shellwords.escape(search))
end

def local_methods(obj = self)
  (obj.methods - obj.class.superclass.instance_methods).sort
end
