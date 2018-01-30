require 'uri'
require 'net/http'
require 'HTTParty'

url = URI("https://slack.com/api/channels.list")

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Get.new(url)
request["Authorization"] = 'Bearer xoxp-305689212499-306644788534-305264393713-d89bdacd47aea7e0cd2fd44d1648f809'
request["Cache-Control"] = 'no-cache'
request["Postman-Token"] = '63d9b9f3-307f-0768-2e21-f474b8068220'

response = http.request(request)
puts response.read_body