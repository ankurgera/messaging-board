class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :posts
  has_many :comments

  def full_name
    "#{first_name} #{last_name}"
  end
end
