class AdminController < ApplicationController
  before_action :admin_user
  before_action :set_tag, only: %i[show edit update destroy]
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

  def feedback
    @complains = Complain.all
    @complain = Complain.new
  end

  def committee
    @tags = Tag.all
    @tag = Tag.new
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Created successfully'
    else
      flash[:error] = 'Name cannot be empty'
    end
    redirect_to admin_committee_path
  end

  def edit
    if params[:complain]
      if @complain.update(complain_params)
        flash[:success] = 'form updated'

      else
        flash[:error] = 'Error in updating Tag'
      end
      redirect_to admin_feedback_path
    else
      if @tag.update(tag_params)
        flash[:success] = 'Tag updated'

      else
        flash[:error] = 'Error in updating Tag'
      end
      redirect_to admin_committee_path
    end
  end

  def destroy
    if params[:tag]
      flash[:success] = 'Tag deleted successfully' if @tag.destroy
      redirect_to admin_committee_path
    elsif params[:complain]
      flash[:success] = 'complain deleted successfully' if @complain.destroy
      redirect_to admin_feedback_path
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:tag][:id]) if params[:tag]
    @complain = Complain.find(params[:complain][:id]) if params[:complain]
  end

  def tag_params
    params.require(:tag).permit(:id, :name)
  end

  def complain_params
    params.require(:complain).permit(:id, :updatedBy, :status)
  end

  def admin_user
    redirect_to(root_path) unless current_user&.is_admin
  end
end
