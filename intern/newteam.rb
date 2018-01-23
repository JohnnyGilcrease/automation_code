require "harvested"
#require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)


user = Harvest::User.new(first_name: '', last_name: '', email: '', timezone: :est, password: '')
user = harvest.users.create(user)
user_assignment = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)
harvest.user_assignments.create(user_assignment)



user = Harvest::User.new(first_name: '', last_name: '', email: '', timezone: :est, password: '')
user = harvest.users.create(user)
user_assignment = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)



user = Harvest::User.new(first_name: '', last_name: '', email: '', timezone: :est, password: '')
user = harvest.users.create(user)
user_assignment = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)
harvest.user_assignments.create(user_assignment)
