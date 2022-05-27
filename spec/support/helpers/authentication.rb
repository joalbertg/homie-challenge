# frozen_string_literal: true

module Authentication
  def login(user, password = '123456')
    client = KeycloakClient::Admin.from_env
    @token = client.user_token(username: user.external[:email], password: password)
  end

  def auth_headers
    {
      authorization: "Bearer #{@token['access_token']}"
    }
  end
end
