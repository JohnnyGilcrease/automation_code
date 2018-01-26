require "harvested"
require "pry"

harvest = Harvest.hardy_client(
  {
    subdomain: "asdf7",
    username: "johngilcreasemusic@gmail.com",
    password: "568020jg"
  }
)

binding.pry

harvest.projects.all
harvest.tasks.all
harvest.users.all