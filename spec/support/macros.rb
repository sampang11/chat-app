def user_token(user)
  post user_session_url, params: { user: { email: user.email, password: user.password } }
  JSON.parse(response.body)['access_token']
end

def header_params(args = {})
  { 'Authorization': "Bearer #{args[:token]}", 'Accept': 'Application/json', 'HTTP_ACCEPT_LANGUAGE': args[:locale] || 'en' }
end