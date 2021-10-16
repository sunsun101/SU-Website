class AdminController < ApplicationController
  def users
    ban_user(params[:user_ban]) if params[:user_ban]
    un_ban_user(params[:user_unban]) if params[:user_unban]
    @users = User.all
    @users = @users.order(:created_at)
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
end
