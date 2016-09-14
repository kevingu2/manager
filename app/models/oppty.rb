class Oppty < ActiveRecord::Base
  has_many :user_oppties, dependent: :destroy
  has_many :users, through: :user_oppties
  has_many :notifications,  dependent: :destroy
  has_many :users, through: :notifications
  validates :opptyId  , uniqueness: true , presence: true
end
