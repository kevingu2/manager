class User < ActiveRecord::Base
  roles = [ "Writer", "Manager" ]
  validates :name, presence:true, uniqueness:true
  validates :role, presence:true
  has_secure_password
  has_many :line_items, dependent: :destroy
  has_many :history, dependent: :destroy
end
