# == Schema Information
#
# Table name: new_emails
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  address    :string(255)      not null
#  value      :string(255)      not null
#  used       :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

class NewEmail < ActiveRecord::Base
  scope :not_userd, -> { where(used: false) }

  validates :address, presence: true, email: { allow_blank: true }
  validate :exists_address

  before_save do
    self.value = NewEmail.create_salt
  end

  def delivery_token
    AccountMailer.new_email(self).deliver
  end

  class << self
    def create_salt
      d = Digest::SHA1.new
      now = Time.now
      d.update(now.to_s)
      d.update(String(now.usec))
      d.update(String(rand(0)))
      d.update(String($$))
      d.update('hermit')
      d.hexdigest
    end
  end

  private
  def exists_address
    if Email.exists?(address: self.address)
      errors.add(:address, :already)
    end
  end
end
