class Authenticator
  def initialize(email)
    @email = email
  end

  def authenticate(raw_password)
    @email &&
      @email.user &&
      @email.user.hashed_password &&
      BCrypt::Password.new(@email.user.hashed_password) == raw_password
  end
end
