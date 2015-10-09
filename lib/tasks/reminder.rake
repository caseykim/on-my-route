namespace :reminder do
  task text: :environment do
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    # time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    body = "Hi Casey."
    message = @client.account.messages.create(
      from: @twilio_number,
      to: "+17143377178",
      body: body,
    )
    puts message.to
  end
end
