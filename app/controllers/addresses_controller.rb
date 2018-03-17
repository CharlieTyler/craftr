class AddressesController < ApplicationController
  
  private

  def address_params
    params.require(:address).permit(:firstname,
                                    :surname,
                                    :line_1,
                                    :line_2,
                                    :line_3,
                                    :post_town,
                                    :postcode)
  end
end
