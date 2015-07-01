class History < ActiveRecord::Base
  belongs_to :oppty
  belongs_to :user
end
