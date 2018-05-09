class Account::SoldItemsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @sold_item = SoldItem.find(params[:id])
    unless @sold_item.user == current user
      flash[:alert] = "You may only view your own order"
      redirect_to me_path
    end
  end
end
