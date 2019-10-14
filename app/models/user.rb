class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  validates :first_name,:last_name,:email,:password,:password_confirmation,presence: true
  mount_uploader :image, ImageUploader
end
