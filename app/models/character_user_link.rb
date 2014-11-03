# == Schema Information
#
# Table name: character_user_links
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  character_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterUserLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :character

  class << self
    def create_character_user_links(character_id, user_id)
      self.create!(user_id: user_id, character_id: character_id)
    end

    def delete_character_user_links(character_id, user_id)
      links = self.where(user_id: user_id, character_id: character_id)
      links.each do |link|
        link.destroy
      end
    end
  end
end
