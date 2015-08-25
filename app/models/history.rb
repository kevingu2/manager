class History < ActiveRecord::Base
  has_many :user_histories, dependent: :destroy
  has_many :users, through: :user_histories
end
