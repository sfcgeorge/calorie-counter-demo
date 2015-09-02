include ActionController::HttpAuthentication::Token

class AuthenticationTokenStrategy < ::Warden::Strategies::Base
  def valid?
    authentication_token
  end

  def authenticate!
    puts authentication_token
    user = User.find_by_token(authentication_token)
    user.nil? ? fail!("strategies.authentication_token.failed") : success!(user)
  end

  private

  def authentication_token
    if (token = token_and_options(ActionDispatch::Request.new env))
      token.first
    end
  end
end
