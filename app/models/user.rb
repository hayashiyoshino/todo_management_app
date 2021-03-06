class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :tasks, dependent: :destroy
  has_many :group_users
  has_many :groups, through: :group_users, dependent: :destroy
  has_one_attached :image
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {minimum: 6}
  before_destroy :check_admin_exist
  before_update :check_admin_exist

  def check_admin_exist
     raise "管理者はこれ以上減らせません" if User.where(admin: true).size <= 1
  end
end
