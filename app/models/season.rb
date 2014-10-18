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

  scope :now, ->{ where(deleted_at: nil, use: true) }
  scope :active, ->{ where(deleted_at: nil) }
  
  class << self
    def import_csv
      path = Rails.root.join("db", "seeds", "data", "mla_export_p_game.csv")
      if File.exists?(path)
        file = path.read
        data = NKF::nkf('-w', file)
        csv = CSV.new(data)
        csv.each_with_index do |arr, idx|
          data_arr = arr[0].split(";")
          unless Season.exists?(year: data_arr[32])
            s = self.new(year: data_arr[32].to_i, name: "赤坂リーグ#{data_arr[32]}")
            if s.year == Time.now.year
              s.use = true
            end
            s.save
          end
        end
      else
        return false
      end
    end
  end
end
