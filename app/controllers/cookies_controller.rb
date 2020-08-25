class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.count > 0
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookies = @oven.build_cookies
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    @cookies = @oven.bake_cookies(cookie_params)

    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings, :amount)
  end
end
