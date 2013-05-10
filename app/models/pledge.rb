class Pledge < ActiveRecord::Base
  belongs_to :user

  default_scope order('created_at DESC')

  scope :recent_pledges,
  		where('pledges.updated_at > ?', 1.month.ago)
  
  validates :pledge_description, :presence => true
  validates :pledge_title, :presence => true

  attr_accessible :pledge_description, :pledge_title, :user_id

end
