require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::Web::Client.new

client.auth_test

channels.create (name:)

users.invite (name:)