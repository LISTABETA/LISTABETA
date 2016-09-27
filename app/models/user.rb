class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :startups, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :email, :name, presence: true
end
