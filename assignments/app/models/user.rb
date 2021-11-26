class User < ApplicationRecord
  paginates_per 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :complains, dependent: :delete_all
  belongs_to :tag, optional: true
  before_save :make_first_user_an_admin
  validates :email, presence: true, if: :domain_check
  validates_presence_of :tag_id, allow_nil: true

  APPROVED_DOMAINS = ['ait.asia', 'ait.ac.th']
  def self.create_from_google_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def domain_check
    errors.add(:email, 'is not from a valid domain') if email && !APPROVED_DOMAINS.any? { |word| email.end_with?(word) }
  end

  def make_first_user_an_admin
    self.is_admin = true if User.count.zero?
  end
end
