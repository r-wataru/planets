# == Schema Information
#
# Table name: pitchers
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  game_id         :integer          not null
#  pitching_number :integer          default(0), not null
#  hit             :integer          default(0), not null
#  run             :integer          default(0), not null
#  remorse_point   :integer          default(0), not null
#  strikeouts      :integer          default(0), not null
#  winning         :integer          default(0), not null
#  defeat          :integer          default(0), not null
#  hold_number     :integer          default(0), not null
#  save_number     :integer          default(0), not null
#  reflection      :boolean          default(FALSE), not null
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_pitchers_on_user_id  (user_id)
#

require 'csv'
require "kconv"
require 'nkf'
class Pitcher < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :user_id, :game_id, :pitching_number, :hit, :run, :remorse_point,
    :strikeouts, :winning, :defeat, :hold_number, :save_number, presence: true
  validate :check_helper_member
  validates :user_id, uniqueness: { scope: :game_id }

  attr_accessor :helper_member

  scope :active, -> { where(reflection: true) }
  scope :alive, ->{ where(deleted_at: nil) }

  before_create do
    if self.user_id == 0
      u = User.create_helper_user(self.helper_member)
      self.user_id = u.id
    end
  end

  after_save do
    if Pitcher.where(self.game_id).map(&:reflection).include?(true)
      self.update_column(:reflection, true)
    end
  end

  class << self
    def pitcher_labels
      ["選手", "投球回", "被安打", "失点", "自責点", "三振", "勝", "負", "ホールド", "セーブ"]
    end

    def pitcher_keys
      [ :user_id, :pitching_number, :hit, :run, :remorse_point,
        :strikeouts, :winning, :defeat, :hold_number, :save_number ]
    end

    def import_csv
      path = Rails.root.join("db", "seeds", "data", "mla_export_p_pitcher.csv")
      if File.exist?(path)
        file = path.read
        data = NKF::nkf('-w', file)
        csv = CSV.new(data)
        csv.each_with_index do |arr, idx|
          data_arr = arr[0].split(";")
          if User.exists?(display_name: data_arr[2])
            user = User.find_by_display_name(data_arr[2])
            transaction do
              user.pitchers.create(
                game_id: data_arr[0],
                pitching_number: data_arr[3],
                hit: data_arr[4],
                run: data_arr[5],
                remorse_point: data_arr[6],
                strikeouts: data_arr[7],
                winning: data_arr[8],
                defeat: data_arr[9],
                hold_number: data_arr[10],
                save_number: data_arr[11],
                reflection: true)
            end
          end
        end
      else
        return false
      end
    end
  end

  private
  def check_helper_member
    if user_id == 0
      if helper_member.blank?
        errors.add(:helper_member)
        errors.add(:user_id)
      end
    end
  end
end
