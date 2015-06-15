module Helpers
  def login_as_user1
    post login_url, { user: { email: User.first.email, password: "123456" } }
  end
end