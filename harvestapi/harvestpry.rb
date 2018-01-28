require "harvested"
require "pry"

harvest = Harvest.hardy_client(
  {
    subdomain: "asdf7",
    username: "johngilcreasemusic@gmail.com",
    password: "568020jg"
  }
)


project = harvest.projects.find(16271516)
project.budget = 6000
updated_project = harvest.projects.update(project)

harvest.projects.all
harvest.tasks.all
harvest.users.all