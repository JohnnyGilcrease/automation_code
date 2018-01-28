require "slack-ruby-client"
require "JSON"

incoming_payload_raw = <<~INCOMING_PAYLOAD
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

payload = JSON.parse(incoming_payload_raw)

Slack.configure do |config|
  config.token = "xoxp-305689212499-306644788534-305694134435-12ca88a38afcdee99688b322689ee176"
end

client = Slack::Web::Client.new

client.channels_create(
  name: payload["projectName"]
  )

client.users_admin_invite(
  email: payload["email"]
  )









