# == Schema Information
#
# Table name: characters
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  condition   :integer          default(0), not null
#  use_type    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'csv'
require "kconv"
require 'nkf'
class Character < ActiveRecord::Base
  has_many :character_user_links
  has_many :users, through: :character_user_links, source: :user

  validates :name, :description, presence: true

  scope :pitcher, -> { where(use_type: true) }
  scope :result, -> { where(use_type: false) }

  class << self
    def import_csv
      path = Rails.root.join("db", "seeds", "data", "mla_export_p_attribute_mst.csv")
      if File.exists?(path)
        file = path.read
        data = NKF::nkf('-w', file)
        csv = CSV.new(data)
        csv.each_with_index do |arr, idx|
          data_arr = arr[0].split(";")
          unless self.exists?(name: data_arr[2])
            self.create(
              use_type: data_arr[1] == "True" ? true : false,
              name: data_arr[2],
              condition: data_arr[3],
              description: data_arr[4]
            )
          end
        end
      else
        return false
      end
    end

    def new_charcter(params)
      type = params[:type] == "d" ? false : true
      n = self.new(
        name: params[:value],
        description: params[:description],
        condition: params[:condition],
        use_type: type
      )
      if n.save
        success = true
        error_message = []
        error_keys = []
        c_id = n.id
      else
        success = false
        error_message = n.errors.messages
        error_keys = n.errors.messages.map{|k,v| k}
      end
      return success, error_message, error_keys, c_id
    end
  end
end
