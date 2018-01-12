require "harvested"
require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

project = "Dr Thunder"
task1 = "Senior Developer"
task2 = "Partner"
task3 = "Exploration and Delivery of Findings"

puts "\nPlease search for a project by typing part of the name:"
project_name = project
project_search_results = harvest.projects.all.select { |c| c.name.include?(project_name) }
case project_search_results.length
when 1
	# Result is exactly 1. We got the client.
	project_index = 0
	project_name = project_search_results[project_index]
	puts "\nProject found: #{project_name}\n"
end
#task_assignment = Harvest::TaskAssignment.new(task_id: 8980470, project_id: project.id)
#task_assignment = harvest.task_assignments.create(task_assignment)
#puts "Assigned the task 'Senior Developer' to the project 'Quantasy'"
#task = Harvest::Task.new(name: 'Senior Developer', hourly_rate: 150, billable: true)

#task_assignment = Harvest::TaskAssignment.new(task_id: 9001911, project_id: project.id)
#task_assignment = harvest.task_assignments.create(task_assignment)
#puts "Assigned the task 'Partner' to the project 'Quantasy'"
#task = Harvest::Task.new(name: 'Partner', hourly_rate: 300, billable: true)

#task_assignment = Harvest::TaskAssignment.new(task_id: 9002837, project_id: project.id)
#task_assignment = harvest.task_assignments.create(task_assignment)
#puts "Assigned the task 'Exploration and Delivery of Findings' to the project 'Quantasy'"
#task = Harvest::Task.new(name: 'Exploration and Delivery of Findings', hourly_rate: 0, billable: true)

puts "\nPlease search for a task by typing part of its name:"
taska = task1
# Filter out all the clients that don't match the typed string
task_search_results = harvest.tasks.all.select { |t| t.name.include?(taska) }
case task_search_results.length
when 0
	task = Harvest::Task.new(name: taska, hourly_rate: 150, billable: true)
	task = harvest.tasks.create(task)
	task_assignment = Harvest::TaskAssignment.new(task_id: task.id, project_id: project.id)
	task_assignment = harvest.task_assignments.create(task_assignment)
	puts "Assigned the task 'Senior Developer' to the project 'Dr Thunder'"
	task = Harvest::Task.new(name: 'Senior Developer', hourly_rate: 150, billable: true)

when 1
	binding.pry
	# Result is exactly 1. We got the client.
	task_index = 0
	task = task_search_results[task_index]
	puts "\nTask found: #{taska}\n"
	task_assignment = Harvest::TaskAssignment.new(task_id: task.id, project_id: project.id)
	task_assignment = harvest.task_assignments.create(task_assignment)
	puts "Assigned the task #{taska} to the project #{project_name}"

end