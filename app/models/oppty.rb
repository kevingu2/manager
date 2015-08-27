class Oppty < ActiveRecord::Base
  has_many :user_oppties, dependent: :destroy
  has_many :users, through: :user_oppties
  has_many :users, through: :notifications

end
