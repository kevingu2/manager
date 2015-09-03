class History < ActiveRecord::Base
  has_many :user_histories, dependent: :destroy
  has_many :users, through: :user_histories
  has_many :users, through: :notification_histories
  has_many :notification_histories, dependent: :destroy
  validates :opptyId, uniqueness: true , presence: true
end
