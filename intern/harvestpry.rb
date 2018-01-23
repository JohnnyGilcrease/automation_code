require "harvested"
require "pry"

subdomain = 'asdf7'
username = 'johngilcreasemusic@gmail.com'
password = '568020jg'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

binding.pry

harvest.projects.all
harvest.tasks.all
harvest.users.all