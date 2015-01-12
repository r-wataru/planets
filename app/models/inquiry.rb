# == Schema Information
#
# Table name: inquiries
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  subject    :string(255)      not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Inquiry < ActiveRecord::Base
  include AfterNewspaper

  after_save do
    AccountMailer.inquiry(self).deliver
  end

  validates :email, presence: true, email: { allow_blank: true }
  validates :subject, :name, :body, presence: true
end
