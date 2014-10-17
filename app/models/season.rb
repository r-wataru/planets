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

require 'csv'
require "kconv"
require 'nkf'
class Season < ActiveRecord::Base
  has_many :games
  has_many :results
  has_many :pitchers

  scope :now, ->{ where(deleted_at: nil, use: true) }
  scope :active, ->{ where(deleted_at: nil) }
end
