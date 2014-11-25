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
#  ability         :text
#  range           :text
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
  include PasswordHolder

  has_many :emails
  has_many :pitchers
  has_many :results
  has_many :character_user_links
  has_many :characters, through: :character_user_links, source: :character
  has_many :breaking_ball_user_links
  has_many :breaking_balls, through: :breaking_ball_user_links, source: :breaking_ball
  has_one :image, class_name: "UserImage", dependent: :destroy

  validate :display_name, presence: true

  scope :alive, ->{ where(deleted_at: nil) }
  scope :member, -> { where(helper: false) }

  store :ability, accessors: [ :shot, :meet, :power, :run, :shoulder, :defend, :stamina, :speed, :control, :throw, :hit ]
  store :range, accessors: [ :one, :two, :three, :four, :five, :six, :seven, :eight, :nine ]

  before_save do
    unless self.birthday.nil?
      self.age = age_calculation
    end
  end

  def update_ability(feild, value)
    eval("self.#{feild} = #{value}")
    self.save
  end

  def display_ability(key)
    self.send(key).to_i
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

  def display_user_name
    self.helper ? self.display_name + "(助)" : self.display_name
  end

  def hitting_name
    if ability.has_key?(:hit)
      case ability[:hit]
      when 1
        "右打"
      when 2
        "左打"
      when 3
        "両打"
      end
    end
  end

  def throwing_name
    if ability.has_key?(:throw)
      case ability[:throw]
      when 1
        "右投"
      when 2
        "左投"
      when 3
        "両投"
      end
    end
  end

  class << self
    def create_helper_user(name)
      number = User.all.map(&:number).max
      number = number + 1
      self.create(
        number: number,
        login_name: "helper",
        display_name: name,
        helper: true)
    end
    
    def test_mailer
      AccountMailer.test_user.deliver
    end
  end
end
