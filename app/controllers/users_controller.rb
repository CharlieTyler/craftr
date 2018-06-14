class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
    @address = Address.new
  end

  def export_data
    respond_to do |format|
      # Gather all user data
      @users = []
      @users << current_user

      format.csv {
        filename = "Your-data-#{Time.now.in_time_zone('London').strftime("%Y%m%d%H%M%S")}.csv"
        send_data(@users.to_a.to_csv, :type => "text/csv; charset=utf-8; header=present", :filename => filename)
      }
    end
  end
end
