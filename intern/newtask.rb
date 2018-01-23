require "harvested"
require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

task_assignment = Harvest::TaskAssignment.new(task_id: , project_id: )
task_assignment = harvest.task_assignments.create(task_assignment)
task = Harvest::Task.new(name: '', hourly_rate: , billable: true)

task_assignment = Harvest::TaskAssignment.new(task_id: , project_id: )
task_assignment = harvest.task_assignments.create(task_assignment)
task = Harvest::Task.new(name: '', hourly_rate: , billable: true)

task_assignment = Harvest::TaskAssignment.new(task_id: , project_id: )
task_assignment = harvest.task_assignments.create(task_assignment)
task = Harvest::Task.new(name: '', hourly_rate: , billable: true)

