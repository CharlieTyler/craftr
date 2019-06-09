class ErrorsController < ApplicationController
  def not_found
    @suggested_products = Product.all.sample(4)
    render status: 404
  end

  def unacceptable
    render status: 422
  end

  def internal_server_error
    render status: 500
  end
end
