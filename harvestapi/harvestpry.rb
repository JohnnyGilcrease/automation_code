require "harvested"
require "pry"

subdomain = 'twinenginelabs'
username = 'john@twinenginelabs.com'
password = '568020jeG!'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

binding.pry

harvest.projects.all
harvest.tasks.all
harvest.users.all