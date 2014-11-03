class CharactersController < ApplicationController
  def update
    @user = User.find(params[:user_id])
    @character = Character.find(params[:id])
    if CharacterUserLink.create_character_user_links(@character.id, @user.id)
      render text: "OK"
    else
      render text: "NG"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @character = Character.find(params[:id])
    if CharacterUserLink.delete_character_user_links(@character.id, @user.id)
      render text: "OK"
    else
      render text: "NG"
    end
  end
end