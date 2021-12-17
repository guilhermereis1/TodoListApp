namespace :print do
  desc "Print all Events from each users"
  task events: :environment do
    User.all.each do |user|
      data = {
        user: user.email,
        events: user.events.each do |event|
          "Event: #{event.name} #{event.event_type} #{event.properties}"
        end
      }
      puts data
    end
  end
end
