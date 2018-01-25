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

payload = {
  "harvest_data" => {},
  "webhook_data" => JSON.parse(webhook_payload)
}

HARVEST_API = Harvest.hardy_client(
  {
    subdomain: "asdf7",
    username: "johngilcreasemusic@gmail.com",
    password: "568020jg"
  }
)

def create_client(payload)
  client_name = payload["webhook_data"]["acceptanceData"]["name"] rescue nil
  if client_name
    HARVEST_API.clients.create(Harvest::Client.new({ name: client_name })) rescue nil
    harvest_client = HARVEST_API.clients.all.select { |client| client.name == client_name }[0] rescue nil
    if harvest_client
      payload["harvest_data"]["client"] = harvest_client
      create_project(payload)
    end
  end
end

def create_project(payload)
  configured_quote = JSON.parse(`python -c "import json; print(json.dumps(eval(str(#{payload['webhook_data']['acceptanceData']['configuredQuote']}))))"`)[0] rescue nil
  if configured_quote
    project_name = payload["webhook_data"]["projectName"]
    HARVEST_API.projects.create(
      Harvest::Project.new(
        {
          name: project_name,
          active: true,
          billalbe: true,
          client_id: payload["harvest_data"]["client"]["id"],
          notes: (configured_quote["ui"]["items"][0]["name"] rescue "N/A")
        }
      )
    ) rescue nil
    harvest_project = HARVEST_API.projects.all.select { |project| project.name == project_name }[0] rescue nil
    if harvest_project
      payload["harvest_data"]["project"] = harvest_project
      payload["harvest_data"]["configured_quote"] = configured_quote
      create_tasks(payload)
    end
  end
end

def create_tasks(payload)
  quoted_tasks = payload["harvest_data"]["configured_quote"]["items"]
  payload["harvest_data"]["tasks"] = []
  quoted_tasks.each do |quoted_task|
    HARVEST_API.tasks.create(
      Harvest::Task.new(
        {
          name: quoted_task["name"],
          default_hourly_rate: quoted_task["rate"]["rate"],
          billable: true
        }
      )
    ) rescue nil
    harvest_task = HARVEST_API.tasks.all.select{ |task| task.name == quoted_task["name"] }[0] rescue nil
    if harvest_task
      payload["harvest_data"]["tasks"] << harvest_task
    end
  end
  create_task_assignments(payload)
end

def create_task_assignments(payload)
  payload["harvest_data"]["tasks"].each do |task|
    HARVEST_API.task_assignments.create(
      Harvest::TaskAssignment.new(
        {
          task_id: task["id"],
          project_id: payload["harvest_data"]["project"]["id"]
        }
      )
    ) rescue nil
  end
  create_user_assignments(payload)
end


def create_user_assignments(payload)
binding.pry
  # HARVEST_API.user_assignments.create(
  #   Harvest::UserAssignment.new(
  #     {
  #       user_id: "",
  #       project_id: ""
  #     }
  #   )
  # )
end

create_client(payload)
