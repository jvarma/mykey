class Profile < ActiveRecord::Base
  attr_accessible :about
  
  belongs_to :user
  
  validates :about, length: { maximum: 200 }

  validates :user_id, presence: true
end
