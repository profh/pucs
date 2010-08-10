class Announcement < ActiveRecord::Base
  named_scope :all, :order => "created_at DESC"
  named_scope :active, :conditions => ['start_date <= ? and end_date >= ?', Time.now.to_date, Time.now.to_date]
  named_scope :recent, lambda { |num| { :limit => num } }
end
