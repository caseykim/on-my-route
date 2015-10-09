class Reminder < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  after_create :remind

  def remind
    @twilio_number = ENV['TWILIO_NUMBER']
    sid = ENV['TWILIO_ACCOUNT_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(sid, token)
    # time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    reminder = "Hi #{user.name}. Time to exercise! #{}."
    message = @client.account.messages.create(
      from: @twilio_number,
      to: user.phone_number,
      body: reminder,
    )
  end
end
