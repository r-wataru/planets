class CharactersController < ApplicationController
  # Ajax PUT
  def update
    @user = User.find(params[:user_id])
    @character = Character.find(params[:id])
    if CharacterUserLink.create_character_user_links(@character.id, @user.id)
      render text: "OK"
    else
      render text: "NG"
    end
  end

  # Ajax DELETE
  def destroy
    @user = User.find(params[:user_id])
    @character = Character.find(params[:id])
    if CharacterUserLink.delete_character_user_links(@character.id, @user.id)
      render text: "OK"
    else
      render text: "NG"
    end
  end

  # Ajax POST
  def create_and_links
    @user = User.find(params[:user_id])
    success,error_message,error_keys,id= Character.new_charcter(params[:users])
    if success
      if CharacterUserLink.create_character_user_links(id, @user.id)
        render text: "OK"
      else
        render text: "NG"
      end
    else
      render json: {
        success: false,
        error_message: error_message,
        error_keys: error_keys
      }
    end
  end
end