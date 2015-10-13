namespace :reminder do
  task text: :environment do
    Reminder.deliver_due.each do |reminder|
      reminder.remind
    end
  end
end
