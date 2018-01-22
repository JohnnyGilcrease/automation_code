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

harvest = Harvest.hardy_client(
  {
    subdomain: "testcompanyname1",
    username: "happyminded@mailinator.com",
    password: "harvest2017"
  }
)

def create_client(webhook_payload_parsed)
  client_name = webhook_payload_parsed["acceptanceData"]["name"] rescue nil
  client_search_results = harvest.clients.all.select { |c| c.name.include?(client_name) }
  case client_search_results.length
  when 0
  client = Harvest::Client.new(name: client_name)
  client = harvest.clients.create(client)
  when 1
  client_index = 0
  client = client_search_results[client_index]
  end
end

create_client(webhook_payload_parsed)
