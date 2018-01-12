import harvest

client = harvest.Harvest("estcompanyname1", "happyminded@mailinator.com", "harvest2017")

project_name = "Gamers"
client = "John"
client_id = 1234567890
billable = True  
bill_by = "project"
budget_by = "project"
notes = "none"
project = [project_name, client, client_id, billable, bill_by, budget_by, notes]
harvest.projects.create(project)
harvest.projects.all   # list out projects