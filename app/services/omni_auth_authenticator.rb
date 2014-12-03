class OmniAuthAuthenticator
  class << self
    def verify(auth)
      return false unless auth.kind_of?(Hash)
      return false if auth['provider'].blank?
      return false if auth['uid'].blank?
      return false if auth['info']['email'].blank?
      if user_identity = UserIdentity.where(provider: auth['provider'], uid: auth['uid'], info: auth['info']['email']).first
        user_identity
      else
        UserIdentity.new(provider: auth['provider'], uid: auth['uid'], info: auth['info']['email'])
      end
    end
  end
end
