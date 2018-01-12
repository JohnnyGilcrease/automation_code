require "google_calendar"
require "active_support"
require "active_support/core_ext"
require "pry"
require "httparty"
Dir["agents/*.rb"].each { |file| require_relative file }

puts "Executing Routine..."
Agent_1.execute()
puts "Finished Routine"
