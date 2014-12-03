# == Schema Information
#
# Table name: passwords
#
#  id              :integer          not null, primary key
#  hashed_password :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Password < ActiveRecord::Base
  include PasswordHolder
end
