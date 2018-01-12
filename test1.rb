require "harvested"
require "pry"
require "httparty"
subdomain = 'testcompanyname1'
username = 'happyminded@mailinator.com'
password = 'harvest2017'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)
project_name = "Gamers"
client = "John"
client_id = 1234567890
billable = true 
bill_by = "project"
budget_by = "project"
notes = "none"
project = [project_name, client, client_id, billable, bill_by, budget_by, notes]
binding.pry
client = Harvest::Client.new(:name => "Billable Company LTD.")
client = harvest.clients.create(client)
puts "Creating new project: \"#{project_name}\" for client: #{client}\n"
project = Harvest::Project.new(name: "Gamers", client: "John", client_id: 1234567890, billable: false, bill_by: "project", budget_by: "project", notes: "none")
harvest.projects.create(project)
harvest.projects.all   # list out projects