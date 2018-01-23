require "harvested"
require "pry"

webhook_payload_raw = <<~INCOMING_PAYLOAD
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

webhook_payload_parsed = JSON.parse(webhook_payload_raw)

harvest_client = Harvest.hardy_client(
  {
    subdomain: "asdf7",
    username: "johngilcreasemusic@gmail.com",
    password: "568020jg"
  }
)

def create_client(webhook_payload_parsed, harvest_client)
  client_name = webhook_payload_parsed["acceptanceData"]["name"] rescue nil
  if client_name
    new_client = harvest_client.clients.create(Harvest::Client.new(name: client_name))
    if new_client
      webhook_payload_parsed["new_client"] = new_client
      create_project(webhook_payload_parsed, harvest_client)
    elsif  
      create_project(webhook_payload_parsed, harvest_client)
      
    end
  end
end

def create_project(webhook_payload_parsed, harvest_client)
  configured_quote = JSON.parse(`python -c "import json; print(json.dumps(eval(str(#{webhook_payload_parsed['acceptanceData']['configuredQuote']}))))"`)[0] rescue nil
  if configured_quote
    project = Harvest::Project.new(
      {
        name: webhook_payload_parsed["projectName"],
        active: true,
        billalbe: true,
        client_id: webhook_payload_parsed["new_client"]["id"],
        notes: (configured_quote["ui"]["items"][0]["name"] rescue "N/A")
      }
    )
    project = harvest_client.projects.create(project)
  end
end

def create_task_assignments(webhook_payload_parsed, harvest_client)
end

def create_user_assignments(webhook_payload_parsed, harvest_client)
end

create_client(webhook_payload_parsed, harvest_client)