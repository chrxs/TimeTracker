class User < ApplicationRecord
  after_create :set_default_weekday_settings

  has_one :team
  has_many :days, dependent: :destroy
  has_many :time_records, through: :days, dependent: :destroy
  has_many :weekday_settings, dependent: :destroy

  accepts_nested_attributes_for :weekday_settings

  def self.from_omniauth!(auth, access_token)
    where(slack_uid: auth["user"]["id"]).first_or_create! do |user|
      user.email = auth["user"]["email"]
      user.name = auth["user"]["name"]
      user.slack_uid = auth["user"]["id"]
      user.image_24 = auth["user"]["image_24"]
      user.image_32 = auth["user"]["image_32"]
      user.image_48 = auth["user"]["image_48"]
      user.image_72 = auth["user"]["image_72"]
      user.image_192 = auth["user"]["image_192"]
      user.image_512 = auth["user"]["image_512"]
      user.is_admin = true
    end
  end

  def image
    self.image_512
  end

  private

    def set_default_weekday_settings
      [
        "monday",
        "tuesday",
        "wednesday",
        "thursday",
        "friday",
        "saturday",
        "sunday"
      ].each do |day_of_week|
        self.weekday_settings.build(
          day_of_week: day_of_week,
          required_minutes_logged: day_of_week == "saturday" || day_of_week == "sunday" ? 0 : (8 * 60),
        )
      end
    end
end
