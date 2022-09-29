class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @cars = Favorite.includes(:car).where(user_id: current_user).map(&:car)
  end

  def create
    @favorite = Favorite.new(favorite_params.merge(user_id: current_user.id))
    @favorite.save ? flash[:success] = 'Created!' : flash[:danger] = 'Incorrect!'
  end

  def destroy
    @favorite = Favorite.find_by(favorite_params)
    @favorite.destroy
    redirect_to favorites_path
  end

  private

  def favorite_params
    params.permit(:user_id, :car_id)
  end
end
