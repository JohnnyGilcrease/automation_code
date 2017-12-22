module CodePilot

  def self.send_message(routine, payload)
    if ENV["CODEPILOT_HOSTING_ENV"] == "test"
      pwd = `pwd`.chomp
      temp_file = Tempfile.new("#{routine}-#{Time.now.to_i.to_s}")
      temp_file.write(payload.to_json)
      temp_file.rewind
      begin
        `#{pwd}/#{routine}/init #{temp_file.path}`
      ensure
        temp_file.close
        temp_file.unlink
      end
    elsif ENV["CODEPILOT_HOSTING_ENV"] == "development" || ENV["CODEPILOT_HOSTING_ENV"].nil?
      HTTParty.post(
        "http://localhost:4000/webhooks/routines/#{routine}",
        {
          headers: { "Content-Type" => "application/json" },
          body: payload.to_json
        }
      )
    elsif ENV["CODEPILOT_HOSTING_ENV"] == "production"
      HTTParty.post(
        "http://localhost:80/webhooks/routines/#{routine}",
        {
          headers: { "Content-Type" => "application/json" },
          body: payload.to_json
        }
      )
    end
  end

end
