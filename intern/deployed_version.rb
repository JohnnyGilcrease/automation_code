require "harvested"
require "pry"

webhook_payload = <<~INCOMING_PAYLOAD
{
  "firstName":"Keith",
  "_zap_data_was_live":"True",
  "lastName":"Hanson",
  "accountName":"Twin Engine Labs",
  "link":"https://twinenginelabs.qwilr.com/2mqI05bJR62J",
  "acceptanceData":{  
    "acceptedTotalWithTaxes":"6000",
    "visitToken":"",
    "configuredQuote":"[{u'items': [{u'rate': {u'rate': 150, u'name': u'Senior Developer', u'unit': u'Hour'}, u'cost': 6000, u'name': u'Exploration and Delivery of Findings', u'units': 40, u'type': u'rate', u'interactive': {u'type': u'none'}}], u'total': 6000, u'ui': {u'items': [{u'units': 100, u'rate': {u'rate': 300, u'type': u'rate', u'name': u'Partner', u'unit': u'Hour'}, u'cost': 30000, u'type': u'rate', u'name': u'This is only an indicative quote. A full quote will be given by April.'}]}, u'sortOrder': 3, u'name': u'Custom Software Development'}]",
    "name":"danilo roque",
    "ip":"45.59.254.58",
    "acceptedTotal":"6000",
    "sessionStartedAt":"2017-12-19T00:59:42.000Z",
    "identification":"",
    "linkSecret":"2mqI05bJR62J",
    "acceptedAt":"2017-12-19T16:25:53.835Z",
    "legalEntity":"Quantasy",
    "quoteBlockId":"5a3848ee2fc4e20a009f7b6f",
    "backupCreatedAt":"2017-12-19T16:25:53.835Z",
    "backupHash":"KVJQZuiyRSTXa41qUmSgIzCamy-tRA",
    "email":"danilo@quantasy.com",
    "esigned":"True"
  },
  "_zap_data_last_live_poll":"1514402003",
  "type":"projectAccepted",
  "email":"keith@twinenginelabs.com",
  "projectName":"Twin Engine Labs - Quantasy - Proposal & Agreement + Confidentiality Agreement"
}
INCOMING_PAYLOAD

payload = JSON.parse(webhook_payload)

HARVEST_CLIENT = Harvest.hardy_client(
  {
    subdomain: "asdf7",
    username: "johngilcreasemusic@gmail.com",
    password: "568020jg"
  }
)
binding.pry
def create_client(payload)
  client_name = payload["acceptanceData"]["name"] rescue nil
  if client_name
    HARVEST_CLIENT.clients.create(Harvest::Client.new(name: client_name)) rescue nil
    new_client = HARVEST_CLIENT.clients.all.select { |item| item.name == client_name }[0]
    payload["new_client"] = new_client
    create_project(payload)
  end
end

def create_project(payload)
  configured_quote = JSON.parse(`python -c "import json; print(json.dumps(eval(str(#{payload['acceptanceData']['configuredQuote']}))))"`)[0] rescue nil
  if configured_quote
    project_name = payload["projectName"]
    HARVEST_CLIENT.projects.create(
      Harvest::Project.new(
        {
          name: project_name,
          active: true,
          billalbe: true,
          client_id: payload["new_client"]["id"],
          notes: (configured_quote["ui"]["items"][0]["name"] rescue "N/A")
        }
      )
    ) rescue nil
    new_project = HARVEST_CLIENT.projects.all.select { |item| item.name == project_name }[0]
    payload["new_project"] = new_project
    payload["configured_quote"] = configured_quote
  end
  create_task_assignments(payload)
end

def create_task_assignments(payload)
  task1 = payload["configured_quote"]["items"][0]["rate"]["name"] rescue nil
  task2 = payload["configured_quote"]["ui"]["items"][0]["rate"]["name"] rescue nil
  if task1
    HARVEST_CLIENT.tasks.create(
      Harvest::Task.new(
        { name: task1, 
          hourly_rate: payload["configured_quote"]["items"][0]["rate"]["rate"], 
          billable: true
        }
      )
    ) rescue nil
    new_task1 = HARVEST_CLIENT.tasks.all.select{ |item| item.name == task1 }[0]
    payload["new_task1"] = new_task1
    task_assignment1 = HARVEST_CLIENT.task_assignments.create(
      Harvest::TaskAssignment.new(
        {
          task_id: payload['new_task1']['id'], 
          project_id: payload['new_project']['id']
        }
      )
    ) rescue nil
    if task2
      HARVEST_CLIENT.tasks.create(
      Harvest::Task.new(
        { name: task2, 
          hourly_rate: payload["configured_quote"]["ui"]["items"][0]["rate"]["rate"], 
          billable: true
        }
      )
    ) rescue nil
    new_task2 = HARVEST_CLIENT.tasks.all.select{ |item| item.name == task2 }[0]
    payload["new_task2"] = new_task2
    task_assignment2 = HARVEST_CLIENT.task_assignments.create(
      Harvest::TaskAssignment.new(
        {
          task_id: payload['new_task2']['id'], 
          project_id: payload['new_project']['id']
        }
      )
    ) rescue nil
    end
  end
end

def create_user_assignments(payload)
  user_assignment1 = Harvest::UserAssignment.new(user_id: user.id, project_id: project.id)
  harvest.user_assignments.create(user_assignment)
end

create_client(payload)
