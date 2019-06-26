class Admin::VouchersController < ApplicationController
  def new
    @voucher = Voucher.new
  end

  def create
    @voucher = Voucher.create(voucher_params)
    if @voucher.valid?
      flash[:notice] = "Voucher successfully created"
      redirect_to admin_voucher_path(@voucher)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @voucher = Voucher.find(params[:id])
  end

  def update
    @voucher = Voucher.find(params[:id])
    @voucher.update_attributes(voucher_params)
    if @voucher.valid?
      flash[:notice] = "Voucher successfully updated"
      redirect_to admin_voucher_path(@voucher)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @voucher = Voucher.find(params[:id])
    @voucher.delete
    flash[:alert] = "Voucher successfully deleted"
    redirect_to admin_dashboard_path
  end

  def show
    @voucher = Voucher.find(params[:id])
    @voucher_completed_orders = @voucher.orders.where(paid: true)
  end

  def index
    @vouchers = Voucher.all.order('valid_to DESC')
  end

  private

  def voucher_params
    params.require(:voucher).permit(:name,
                                    :code,
                                    :value,
                                    :valid_from,
                                    :valid_to,
                                    :live)
  end
end
