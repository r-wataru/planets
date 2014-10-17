Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, "667422903356354", "69e822133c06198670a53b1d711a04f8", scope: 'email,user_birthday', display: 'popup'
  else
    provider :facebook, "667422903356354", "69e822133c06198670a53b1d711a04f8", scope: 'email,user_birthday', display: 'popup'
    #OmniAuth.config.on_failure = SessionsController.action(:failure)
  end
end