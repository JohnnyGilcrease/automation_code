require "harvested"
require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)
binding.pry
task_assignment = Harvest::TaskAssignment.new(task_id: 8980470, project_id: 16007429)
task_assignment = harvest.task_assignments.create(task_assignment)
puts "Assigned the task 'Senior Developer' to the project 'Quantasy'"
task = Harvest::Task.new(name: 'Senior Developer', hourly_rate: 30, billable: true)

task_assignment = Harvest::TaskAssignment.new(task_id: 9001911, project_id: 16007429)
task_assignment = harvest.task_assignments.create(task_assignment)
puts "Assigned the task 'Partner' to the project 'Quantasy'"
task = Harvest::Task.new(name: 'Partner', hourly_rate: 30, billable: true)




#task = Harvest::Task.new(name: 'Packaging Glue', hourly_rate: 30, billable: true)
#task = harvest.tasks.create(task)
#task_assignment = Harvest::TaskAssignment.new(task_id: task.id, project_id: project.id)
#task_assignment = harvest.task_assignments.create(task_assignment)
#puts "Assigned the task 'Packaging Glue' to the project 'Quantasy'"

























