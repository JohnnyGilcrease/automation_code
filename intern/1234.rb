require "rubygems"
require "httparty"
require "json"
require "pry"

file = File.read('ex1.json')
puts "Name: #{file[name]}"