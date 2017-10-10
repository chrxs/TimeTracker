class Team < ApplicationRecord
  belongs_to :user
  has_many :projects

  def image
    self.image_230
  end

  def self.from_omniauth!(auth, access_token)
    where(slack_uid: auth["team"]["id"]).first_or_create! do |team|
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
