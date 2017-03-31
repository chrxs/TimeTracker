class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :user_omniauths, dependent: :destroy
  has_many :days, dependent: :destroy
  has_many :time_records, through: :days, dependent: :destroy
  has_many :weekday_settings, dependent: :destroy

  accepts_nested_attributes_for :weekday_settings

  def self.from_omniauth!(auth)
    omniauths_params = { provider: auth.provider, uid: auth.uid }
    user_scope = joins(:user_omniauths).where(user_omniauths: omniauths_params)
    user_scope.first_or_create! do |user|
      user.user_omniauths.build(omniauths_params.merge({
        name: auth.info.name,
        image: auth.info.image,
      }))
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.is_admin = true
      ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"].each do |day_of_week|
        user.weekday_settings.build(
          day_of_week: day_of_week,
          required_minutes_logged: day_of_week == "saturday" || day_of_week == "sunday" ? 0 : (8 * 60),
        )
      end
    end
  end

  def name
    user_omniauths.pluck(:name).compact.first
  end

  def image
    user_omniauths.pluck(:image).compact.first
  end
end
