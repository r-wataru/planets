# == Schema Information
#
# Table name: user_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  email_id   :integer
#  value      :string(255)
#  used       :boolean
#  created_at :datetime
#  updated_at :datetime
#

class UserToken < ActiveRecord::Base
  belongs_to :user
  belongs_to :email

  scope :active, ->{ where(used: false) }

  before_save do
    if self.value.blank?
      self.value = UserToken.create_salt
    end
  end

  after_commit do
    AccountMailer.forgot_password(self).deliver if self.persisted?
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
end
