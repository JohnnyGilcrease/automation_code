# [prosperworks] fetch person

module Agent_1_1
  def self.execute(incoming_payload)
    puts "Executing #{self.to_s}"

    outgoing_payload = []

    incoming_payload.each do |incoming_event|
      if incoming_event[:code] == 0
        begin
            if response_code =~ /2../
              code = 0
            else
              code = "unsuccessful"
            end

            outgoing_payload << {
              code: code,
              meta: {
                response_code: response_code,
                response_body: response_body
              },
              data: {}
            }
        rescue Exception => e
          binding.pry
        end
      end
    end

    Agent_1_1_1.execute(outgoing_payload)
  end
end
