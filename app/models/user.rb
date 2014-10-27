# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  number          :integer
#  login_name      :string(255)
#  hashed_password :string(255)
#  display_name    :string(255)
#  birthday        :date
#  age             :integer
#  logged_at       :datetime
#  description     :text
#  created         :boolean          default(FALSE), not null
#  checked         :boolean          default(FALSE), not null
#  deleted_at      :datetime
#  helper          :boolean          default(FALSE), not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_number  (number) UNIQUE
#

require 'csv'
require "kconv"
require 'nkf'
class User < ActiveRecord::Base
  has_many :emails
  has_many :pitchers
  has_many :results

  before_save do
    unless self.birthday.nil?
      self.age = age_calculation
    end
  end

  def age_calculation
    d1 = self.birthday.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
  end

  def display_age
    if self.age.present?
      return "#{age}歳"
    end
  end

  def email=(address)
    self.emails.build(address: address)
  end

  class << self
    def create_helper_user(name)
      self.create(
        number: 100,
        login_name: "helper",
        display_name: name,
        helper: true)
    end
  end
end
