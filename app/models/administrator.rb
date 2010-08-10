class Administrator < ActiveRecord::Base
  belongs_to :user
  
  def make_inactive
    update_attribute(:active, false)
  end
end
