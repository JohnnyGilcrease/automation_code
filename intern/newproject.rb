require "harvested"
require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

client = "Johnny"
project = "Dr Thunder"

puts "\nPlease search for a client by typing part of their name:"
cname = client
# Filter out all the clients that don't match the typed string
client_search_results = harvest.clients.all.select { |c| c.name.include?(cname) }
case client_search_results.length
when 0
	puts "Clients Name?"
	cname = client 
	client = Harvest::Client.new(name: cname)
	client = harvest.clients.create(client)
	puts "\nClient created!\n"
when 1
	# Result is exactly 1. We got the client.
	client_index = 0
	client = client_search_results[client_index]

	puts "\nClient found: #{client.name}\n"
end
puts "\nPlease search for a project by typing part of the name:"
project_name = project
project_search_results = harvest.projects.all.select { |p| p.name.include?(project_name) }
case project_search_results.length
when 0  
	puts "Please enter the project name:"
	project_name = project
	puts "\nIs this project billable? (y/n)"
	billable = "y"
	puts "\nAny project notes?"
	notes = "This is only an indicative quote. A full quote will be given by April."
	puts "Creating new project: \"#{project_name}\" for client: #{client.name}\n"
	project = Harvest::Project.new(name: project_name, client_id: client.id, billable: billable, notes: notes)
	project = harvest.projects.create(project)
when 1
	# Result is exactly 1. We got the client.
	project_index = 0
	project_name = project_search_results[project_index]
	puts "\nProject found: #{project_name}\n"
	
end

#----------------------------------------------------------------------------------------------------------------------------------------#

task_assignment = Harvest::TaskAssignment.new(task_id: 8980470, project_id: project.id)
task_assignment = harvest.task_assignments.create(task_assignment)
puts "Assigned the task 'Senior Developer' to the project 'Quantasy'"
task = Harvest::Task.new(name: 'Senior Developer', hourly_rate: 150, billable: true)

task_assignment = Harvest::TaskAssignment.new(task_id: 9001911, project_id: project.id)
task_assignment = harvest.task_assignments.create(task_assignment)
puts "Assigned the task 'Partner' to the project 'Quantasy'"
task = Harvest::Task.new(name: 'Partner', hourly_rate: 300, billable: true)

task_assignment = Harvest::TaskAssignment.new(task_id: 9002837, project_id: project.id)
task_assignment = harvest.task_assignments.create(task_assignment)
puts "Assigned the task 'Exploration and Delivery of Findings' to the project 'Quantasy'"
task = Harvest::Task.new(name: 'Exploration and Delivery of Findings', hourly_rate: 0, billable: true)

#----------------------------------------------------------------------------------------------------------------------------------------#

user = Harvest::User.new(first_name: 'Jane1', last_name: 'Doe1', email: 'jane1@doe.com', timezone: :est, password: 'secure')
user = harvest.users.create(user)

user_assignment = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)
harvest.user_assignments.create(user_assignment)
puts 'Assigned Jane1 Doe1 to the project'

user = Harvest::User.new(first_name: 'Jane2', last_name: 'Doe2', email: 'jane2@doe.com', timezone: :est, password: 'secure')
user = harvest.users.create(user)

user_assignment = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)
harvest.user_assignments.create(user_assignment)
puts 'Assigned Jane2 Doe2 to the project'

user = Harvest::User.new(first_name: 'Jane3', last_name: 'Doe3', email: 'jane3@doe.com', timezone: :est, password: 'secure')
user = harvest.users.create(user)

user_assignment = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)
harvest.user_assignments.create(user_assignment)
puts 'Assigned Jane3 Doe3 to the project'
