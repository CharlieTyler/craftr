class Account::AddressesController < ApplicationController
  before_action :authenticate_user!

  def create
    @address = current_user.addresses.create(address_params)
    if @address.valid?
      flash[:notice] = 'Address successfully created'
    else
      flash[:alert] = 'Invalid address'
    end
    redirect_to me_path      
  end

  def edit
    @address = Address.find(params[:id])
    unless @address.user == current_user
      flash[:alert] = "You can only edit your own addresses"
      redirect_to me_path
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update_attributes(address_params)
    if @address.valid? && @address.user == current_user
      flash[:notice] = "Address updated"
      redirect_to me_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.delete
    flash[:alert] = "Address successfully deleted"
    redirect_to me_path
  end

  private

  def address_params
    params.require(:address).permit(:first_name,
                                    :last_name,
                                    :line_1,
                                    :line_2,
                                    :line_3,
                                    :post_town,
                                    :postcode)
  end
end
