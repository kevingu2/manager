class Oppty < ActiveRecord::Base
  has_many :user_oppties, dependent: :destroy
  has_many :history, dependent: :destroy

end
