class AdminController < ApplicationController
  def users
    ban_user(params[:user_ban]) if params[:user_ban]
    un_ban_user(params[:user_unban]) if params[:user_unban]
    @users = User.all
    @users = @users.order(:created_at)
  end

  def ban_user(id)
    @user = User.find(id)
    @user.update(status: 'D')
  end

  def un_ban_user(id)
    @user = User.find(id)
    @user.update(status: 'A')
  end
end
