require "harvested"
#require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

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