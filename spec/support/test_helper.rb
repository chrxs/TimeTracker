module TestHelper
  def create_user()
    user = create :user
    token = JsonWebToken.encode(user: UserSerializer.new(user).as_json)
    request.headers["Authorization"] = token
    user
  end

  def create_admin_user()
    admin_user = create :admin_user
    token = JsonWebToken.encode(user: UserSerializer.new(admin_user).as_json)
    request.headers["Authorization"] = token
    admin_user
  end
end

RSpec.configure do |config|
  config.include TestHelper
end
