module AuthenticationHelper
  def login(user)
    devise_mapping @request
    @request.headers.merge!(user.create_new_auth_token) if user.present?
    sign_in user, scope: :user
  end

  def devise_mapping(request)
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
end
