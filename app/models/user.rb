class User < ActiveRecord::Base
  has_many :reminders
  has_many :constructions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth_hash)
    User.find_or_create_by(
      provider: auth_hash.provider,
      uid: auth_hash.uid
    ) do |user|
      user.name = auth_hash.info.name
      user.email = auth_hash.info.email
      user.image = auth_hash.info.image
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
