require "harvested"
require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

client = "Johnny"
project = "Dr Thunder"
task1 = "Senior Developer"

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
project_search_results = harvest.projects.all.select { |c| c.name.include?(project_name) }
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

puts "\nPlease search for a task by typing part of its name:"
taska = task1
# Filter out all the clients that don't match the typed string
task_search_results = harvest.tasks.all.select { |c| c.name.include?(taska) }
case task_search_results.length
when 0
	task = Harvest::Task.new(name: taska, hourly_rate: 150, billable: true)
	task = harvest.tasks.create(task)
	task_assignment = Harvest::TaskAssignment.new(task_id: task.id, project_id: project.id)
	task_assignment = harvest.task_assignments.create(task_assignment)
	puts "Assigned the task 'Senior Developer' to the project 'Dr Thunder'"
	task = Harvest::Task.new(name: 'Senior Developer', hourly_rate: 150, billable: true)
when 1
	# Result is exactly 1. We got the client.
	task_index = 0
	task = task_search_results[task_index]
	puts "\nTask found: #{taska}\n"
	task_assignment = Harvest::TaskAssignment.new(task_id: task.id, project_id: project.id)
	task_assignment = harvest.task_assignments.create(task_assignment)
	puts "Assigned the task #{taska} to the project #{project_name}"

end





#harvest.projects.all
#harvest.tasks.all
#harvest.users.all