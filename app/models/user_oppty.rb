class UserOppty < ActiveRecord::Base
  belongs_to :oppty
  belongs_to :user
  validates :status, presence: true
end
