require "net/http"
require "uri"
require "json"

base_url = 'hhttps://johneg.wufoo.com/api/code/2/'
username = 'john@twinenginelabs.com'
password = '568020jg'

uri = URI.parse(base_url+"forms/mbhsfm00ay4nw7/webhooks.json")

request = Net::HTTP::Put.new(uri.request_uri)
request.basic_auth(username, password)

request.set_form_data('url' => 'https://wufoo.com',
                      'handshakeKey' => 'secret123',
                      'metadata' => 'true'
                      )

response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
  http.request(request)
}

puts JSON.pretty_generate(JSON[response.body])