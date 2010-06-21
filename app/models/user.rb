# == Schema Information
# Schema version: 20100618055959
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email;

  validates_presence_of :name, :email;
  validates_length_of :name, :maximum => 50;
  validates_uniqueness_of :email;
  
end
