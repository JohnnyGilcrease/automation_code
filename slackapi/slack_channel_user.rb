require "slack-ruby-client"
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
      "email":"johngilcreasemusic@gmail.com",
      "esigned":"True"
   },
   "_zap_data_last_live_poll":"1514402003",
   "type":"projectAccepted",
   "email":"keith@twinenginelabs.com",
   "projectName":"Twin Engine Labs - Quantasy - Proposal & Agreement + Confidentiality Agreement"
}
INCOMING_PAYLOAD

payload = {
  "slack_data" => {},
  "webhook_data" => JSON.parse(webhook_payload)
}

Slack.configure do |config|
  config.token = ""
end

client = Slack::Web::Client.new
binding.pry
def create_channel(payload,client)
  new_channel = payload["webhook_data"]["projectName"]
  if new_channel
    client.channels_create(
      name: new_channel
      )
    slack_channel = client.channels_list.select 
    if slack_channel
      payload["slack_data"]["channel"] = slack_channel
    end
  end
  create_user(payload,client)
end

def create_user(payload,client)
  new_user = payload["webhook_data"]["acceptanceData"]["email"]
  if new_user
    client.users_admin_invite(
      channels: payload["slack_data"]["channel"]["id"],
      email: new_user
      ) 
    payload["slack_data"]["user"] = new_user
  end
end

create_channel(payload,client)