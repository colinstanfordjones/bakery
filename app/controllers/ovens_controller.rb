class OvensController < ApplicationController
  before_action :authenticate_user!

  def index
    @ovens = current_user.ovens
  end

  def show
    @oven = current_user.ovens.find_by!(id: params[:id])
  end

  def empty
    @oven = current_user.ovens.find_by!(id: params[:id])

    if @oven.empty(current_user)
      redirect_to @oven, alert: 'Oven emptied!'
    end    
  end

  def status
    @oven = current_user.ovens.find_by!(id: params[:id])

    render partial: "status"
  end

end
