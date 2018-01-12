# [google] fetch events

module Agent_1
  def self.execute()
    puts "Executing #{self.to_s}"

    outgoing_payload = []

    begin
      binding.pry
      cal = Google::Calendar.new(:client_id => "723218819819-6rlji6j4frt9pu9pvgrmsn763vkbnojj.apps.googleusercontent.com", :client_secret => "MzpifmJGEGt7VdckmQKwmY5K", :calendar => "keith@twinenginelabs.com", :redirect_url  => "urn:ietf:wg:oauth:2.0:oob") 
      cal.login_with_refresh_token("1/MHa72t2-o1Lx0jgytts3Y1SzT5zsgNVZKh_Fvr4Pd3y3cVDTfdOXhQzyxLz-OJ84")
      beginning_of_day = Date.parse("2017-12-07").beginning_of_day
      events = cal.find_events_in_range(beginning_of_day, beginning_of_day + 3.days)
      outgoing_payload << {
        code: 0,
        meta: {},
        data: {
          events: events
        }
      }
    rescue Exception => e
      binding.pry
    end

    Agent_1_1.execute(outgoing_payload)
  end
end
