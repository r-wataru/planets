class ChangePasswordForm
  include ActiveModel::Model
  include PasswordHolder

  attr_accessor :object, :current_password, :new_password,
    :new_password_confirmation, :token, :not_current_user

  validates :new_password, presence: true, confirmation: true

  validate do
    unless not_current_user
      unless Authenticator.new(object).authenticate(current_password)
        errors.add(:current_password, :wrong)
      end
    end
  end

  def save
    if valid?
      object.password = new_password
      object.save!
    end
  end

  def persisted?
    true
  end
end
