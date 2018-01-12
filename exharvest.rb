# Harvest

require "harvested"
require "pry"

binding.pry

harvest = Harvest.client(subdomain: 'testcompanyname1', username: 'happyminded@mailinator.com', password: 'harvest2017')
harvest.projects.all   # list out projects
harvest.projects.create(project)

#  client = Harvest::Client.new(:name => "Billable Company LTD.")
#  client = harvest.clients.create(client)
#  harvest.clients.find(client.id) # returns a Harvest::Client





