class Oppty < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :history, dependent: :destroy
end
