require "harvested"
require "pry"

subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

binding.pry
client = Harvest::Client.new(name: 'John')
client = harvest.clients.create(client)
puts "Creating new project: \"#{project_name}\" for client: #{client.name}\n"
project = Harvest::Project.new(name: 'Games', client_id: 6339546, billable: true, notes: 'none')
harvest.projects.create(project)
harvest.projects.all   # list out projects
