require "harvested"
require "pry"
require "httparty"
subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

puts "\nPlease search for a client by typing part of their name:"
cname = gets.chomp
puts "Please enter the project name:"
project_name = gets.chomp

puts "\nIs this project billable? (y/n)"
billable = gets.chomp.downcase == "y"

puts "\nAny project notes? (hit 'return' for none)"
notes = gets.chomp

puts "\nWhat sorts of tasks does this project need? Type \"p\" for project tasks or \"s\" for sales tasks.\n"
task_types = gets.chomp

#puts "Creating new project: \"#{project_name}\" for client: #{client.name}\n"
project = Harvest::Project.new(name: project_name, client_id: client.id, billable: billable, notes: notes)
project = harvest.projects.create(project)

puts "\nProject successfully created."
puts "You can find the project here: http://#{subdomain}.harvestapp.com/projects/#{project.id}/edit\n\n"
