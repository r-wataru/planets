# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  year       :integer          not null
#  name       :string(255)      not null
#  use        :boolean          default(FALSE), not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_seasons_on_year  (year) UNIQUE
#

class Season < ActiveRecord::Base
end
