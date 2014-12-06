# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  address    :string(255)      not null
#  main       :boolean          default(FALSE), not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_emails_on_address  (address) UNIQUE
#

require 'securerandom'
class Email < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :user

  validates :address, presence: true, uniqueness: true, email: { allow_blank: true }

  def has_emails?
    self.user.emails.count > 1
  end

  def all_update_main
    self.user.emails.each do |email|
      email.update_column(:main, false)
    end
    self.update_column(:main, true)
  end
end
