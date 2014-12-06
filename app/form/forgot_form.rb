class ForgotForm
  include ActiveModel::Model

  attr_accessor :email

  validate :valid_emails

  def send_token
    if valid?
      exists_email = Email.find_by(address: email)
      user_token = UserToken.new(user: exists_email.user, email: exists_email)
      user_token.save
    end
  end

  private
  def valid_emails
    if email.blank?
      errors.add(:email, :blank)
    end
    if email.present? && !Email.exists?(address: email)
      errors.add(:email, :invalid)
    end
  end
end
