# [prosperworks] create person

module Agent_1_1_1
  def self.execute(incoming_payload)
    puts "Executing #{self.to_s}"

    incoming_payload.each do |incoming_event|
      if incoming_event[:code] == 0
        begin
        rescue Exception => e
          binding.pry
        end
      end
    end

  end
end
