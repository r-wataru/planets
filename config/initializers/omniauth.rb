Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, "733895663384185", "38b98a471451aa0d8d6d4dfc11e6dfff", scope: 'email,user_birthday', display: 'popup'
  else
    provider :facebook, "667422903356354", "69e822133c06198670a53b1d711a04f8", scope: 'email,user_birthday', display: 'popup'
    #OmniAuth.config.on_failure = SessionsController.action(:failure)
  end
end