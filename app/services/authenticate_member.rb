class AuthenticateMember
  def initialize(user)
    @user = user
  end

  def authenticate(raw_password)
    if Password.first
      if BCrypt::Password.new(Password.first.hashed_password) == raw_password
        return true
      else
        @user.errors.add(:planets_password, :invalid)
        return false
      end
    else
      @user.errors.add(:planets_password, :invalid)
      return false
    end
  end
end