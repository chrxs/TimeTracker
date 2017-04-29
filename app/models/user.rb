class User < ApplicationRecord
  after_create :set_default_weekday_settings

  belongs_to :team
  has_many :days, dependent: :destroy
  has_many :time_records, through: :days, dependent: :destroy
  has_many :weekday_settings, dependent: :destroy

  accepts_nested_attributes_for :weekday_settings

  def self.from_omniauth!(auth)
    first_or_create! do |user|
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

      user.team = Team.first_or_create! do |team|
        team.name = auth["team"]["name"]
        team.slack_uid = auth["team"]["id"]
        team.domain = auth["team"]["domain"]
        team.image_34 = auth["team"]["image_34"]
        team.image_44 = auth["team"]["image_44"]
        team.image_68 = auth["team"]["image_68"]
        team.image_88 = auth["team"]["image_88"]
        team.image_102 = auth["team"]["image_102"]
        team.image_132 = auth["team"]["image_132"]
        team.image_230 = auth["team"]["image_230"]
      end
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
