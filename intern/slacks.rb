HTTParty.post(
  "SLACK_URL",
  {
    headers: { "Content-Type" => "application/json" },
    body: {
      text: "YOUR_CUSTOM_MESSAGE_HERE"
    }.to_json
  }
)