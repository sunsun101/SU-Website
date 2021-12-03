class AdminController < ApplicationController
  before_action :admin_user
  before_action :set_tag, only: %i[show edit update destroy]
  def users
    @users = User.where('is_admin = true')
    if params[:user]&.present?
      if params[:user][:is_admin] == '1'
        make_admin(params[:user][:id])
      elsif params[:user][:is_admin] == '0'
        remove_admin(params[:user][:id])
      end
      usercommittee(params[:user][:id], params[:user][:tag_id]) if params[:user][:tag_id]&.present?
    end
    advanced_search if params[:adsearch]
    @users = User.where('email ILIKE ?', '%' + params[:search] + '%') if params[:search]&.present?
    @users = @users.order(:created_at).reverse_order.page(params[:page])
  end

  # def ban_user(id)
  #   @user = User.find(id)
  #   @user.update(status: 'D')
  # end

  # def un_ban_user(id)
  #   @user = User.find(id)
  #   @user.update(status: 'A')
  # end

  def make_admin(id)
    @user = User.find(id)
    @user.update(is_admin: true)
  end

  def remove_admin(id)
    @user = User.find(id)
    @user.update(is_admin: false)
  end

  def usercommittee(id, t_id)
    @user = User.find(id)
    @user.tag_id = t_id
    @user.save
  end

  def advanced_search
    @users = User.all
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
    @users = @users.where('tag_id = ?', params[:tag_id]) if params[:tag_id].present?
    if params[:date_from].present? && params[:date_to].present?
      @users = @users.where('created_at BETWEEN ? AND ?', Date.parse(params[:date_from]).beginning_of_day,
                            Date.parse(params[:date_to]).end_of_day)
    end
    @users = @users.page(params[:page])
  end

  def advanced_search_feedback
    @complains = Complain.all
    @complains = @complains.where('status = ?', params[:status]) if params[:status].present?
    @complains = @complains.where('tag_id = ?', params[:tag_id]) if params[:tag_id].present?
    if params[:date_from].present? && params[:date_to].present?
      @complains = @complains.where('created_at BETWEEN ? AND ?', Date.parse(params[:date_from]).beginning_of_day,
                                    Date.parse(params[:date_to]).end_of_day)
    end
  end

  # def count_by_date
  #   User.find_by_sql(<<-SQL
  #     SELECT
  #       date_trunc('day', created_at) AS created_date,
  #       count(id) as total_count
  #     FROM users
  #     WHERE date_part ('year', created_at) = date_part('year',current_date)
  #     GROUP BY created_date
  #     ORDER BY created_date, total_count
  #   SQL
  #                   )
  # end

  def feedback
    @complains = if current_user&.tag_id.present?
                   Complain.where('tag_id = ?', current_user.tag_id)
                 else
                   Complain.all
                 end

    @complain = Complain.new
    advanced_search_feedback if params[:adsearch]
    @complains = Complain.where('subject ILIKE ? ', '%' + params[:search] + '%') if params[:search]&.present?
    @complains = @complains.order(:created_at).reverse_order.page(params[:page])
  end

  def committee
    @tags = Tag.all
    @tag = Tag.new
  end

  # def new
  #   @tag = Tag.new
  # end

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
        flash[:success] = 'From updated'
      else
        flash[:error] = 'Error in updating Form'
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
      @complain.com_pics.purge
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
    params.require(:tag).permit(:id, :name, :email)
  end

  def complain_params
    params.require(:complain).permit(:id, :updatedBy, :status)
  end

  def admin_user
    redirect_to(root_path) unless current_user&.is_admin
  end
end
