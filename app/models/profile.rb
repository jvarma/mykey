class Profile < ActiveRecord::Base
  attr_accessible :about, :user_id
  belongs_to :user
  validates :about, length: { maximum: 200 }
end
