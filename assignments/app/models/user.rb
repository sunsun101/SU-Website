class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  before_save :make_first_user_an_admin
  def self.create_from_google_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def make_first_user_an_admin
    return unless User.count.zero?

    self.is_admin = true
  end

  # def self.count_by_date
  #   find_by_sql(<<-SQL
  #     SELECT
  #       date_trunc('day', created_at) AS created_date,
  #       count(id) as total_count
  #     FROM users
  #     WHERE date_part ('year', created_at) = date_part('year',current_date)
  #     GROUP BY created_date
  #     ORDER BY created_date, total_count
  #   SQL
  #              ).map do |row|
  #     [
  #       row['created_date'].strftime('%e %B'),
  #       row.total_count
  #     ]
  #   end
  # end
end
