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

class User < ActiveRecord::Base
end
