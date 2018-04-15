class Account::AddressesController < AddressesController
  before_action :authenticate_user!
  # Inherits params from addresses controller
  def create
    @address = current_user.addresses.create(address_params)
    if @address.valid?
      flash[:notice] = 'Address successfully created'
    else
      flash[:alert] = 'Invalid address'
    end
    redirect_to me_path      
  end

  def destroy

  end
end
