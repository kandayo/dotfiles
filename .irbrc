# frozen_string_literal: true

require 'awesome_print'
require 'irb/completion'
require 'irb/ext/save-history'
require 'time_difference'

START = Time.now

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

at_exit do
  session_time = TimeDifference.between(START, Time.now).humanize
  puts session_time
end
