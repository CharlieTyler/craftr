class Distiller::AddressesController < DistillersController
  def new
    @address = Address.new
  end

  def create
    @address = current_distillery.create_address(distiller_address_params)
    if @address.valid?
      flash[:notice] = "Address successfully added"
    else
      flash[:error] = "Address not added - please try again"
    end
    redirect_to distiller_transactional_checklist_path
  end

  def edit
    @address = current_distillery.address
  end

  def update
    @address = Address.find(params[:id])
    @address.update_attributes(distiller_address_params)
    if @address.valid?
      @address.create_easypost_address
      flash[:notice] = "Address successfully Updated"
    else
      flash[:error] = "Address not updated - please try again"
    end
    redirect_to distiller_transactional_checklist_path
  end

  private

  def distiller_address_params
    params.require(:address).permit(:first_name,
                                    :last_name,
                                    :phone_number,
                                    :line_1,
                                    :line_2,
                                    :line_3,
                                    :post_town,
                                    :postcode,
                                    :country)
    
  end
end
