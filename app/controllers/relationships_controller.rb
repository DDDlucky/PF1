class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @relationship = current_user.active_relationships.create(followed_id: params[:followed_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @relationship = current_user.active_relationships.find_by(id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
end
