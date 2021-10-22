class AdminController < ApplicationController
  before_action :admin_user
  def users
    @users = User.all
    if params[:user]&.present?
      if params[:user][:status] == 'Active'
        un_ban_user(params[:user][:id])
      elsif params[:user][:status] == 'Ban'
        ban_user(params[:user][:id])
      elsif params[:user][:is_admin] == '1'
        make_admin(params[:user][:id])
      elsif params[:user][:is_admin] == '0'
        remove_admin(params[:user][:id])
      end
    end
    advanced_search if params[:adsearch]
    @users = @users.where('email ILIKE ?', '%' + params[:search] + '%') if params[:search]&.present?
    @users = @users.order(:created_at).reverse_order
    user_stats = count_by_date
    @data = []
    sts = []
    user_stats.each do |val|
      sts  << val['created_date'].strftime('%e %B')
      sts  << val['total_count']
      @data << sts
      sts = []
    end
  end

  def ban_user(id)
    @user = User.find(id)
    @user.update(status: 'D')
  end

  def un_ban_user(id)
    @user = User.find(id)
    @user.update(status: 'A')
  end

  def make_admin(id)
    @user = User.find(id)
    @user.update(is_admin: true)
  end

  def remove_admin(id)
    @user = User.find(id)
    @user.update(is_admin: false)
  end

  def advanced_search
    if params[:user_status]
      if params[:user_status] == 'Active'
        @users = @users.where('status = ?',  'A')
      elsif params[:user_status] == 'Banned'
        @users = @users.where('status = ?',  'D')
      end
    end
    if params[:admin]
      if params[:admin] == 'Admin'
        @users = @users.where('is_admin = ?',  true)
      elsif params[:admin] == 'Members'
        @users = @users.where('is_admin = ?',  false)
      end
    end
    if params[:date_from].present? && params[:date_to].present?
      @users = @users.where('created_at BETWEEN ? AND ?', Date.parse(params[:date_from]).beginning_of_day,
                            Date.parse(params[:date_to]).end_of_day)
    end
  end

  def count_by_date
    User.find_by_sql(<<-SQL
      SELECT
        date_trunc('day', created_at) AS created_date,
        count(id) as total_count
      FROM users
      WHERE date_part ('year', created_at) = date_part('year',current_date)
      GROUP BY created_date
      ORDER BY created_date, total_count
    SQL
                    )
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user&.is_admin
  end
end
