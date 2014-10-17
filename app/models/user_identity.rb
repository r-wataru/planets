# == Schema Information
#
# Table name: user_identities
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  info       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_user_identities_on_provider_and_uid_and_info  (provider,uid,info) UNIQUE
#

class UserIdentity < ActiveRecord::Base
end
