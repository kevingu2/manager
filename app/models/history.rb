class History < ActiveRecord::Base
  has_many :user_histories, dependent: :destroy
  has_many :histories, through: :user_histories
end
