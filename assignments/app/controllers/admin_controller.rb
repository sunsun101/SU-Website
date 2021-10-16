class AdminController < ApplicationController
  def users
    ban_user(params[:user_id]) if params[:user_id]
    @users = User.all
    @data = User.count_by_date
  end

  def ban_user(id); end
end
