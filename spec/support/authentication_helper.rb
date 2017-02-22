module AuthenticationHelper
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user, scope: :user
  end
end
