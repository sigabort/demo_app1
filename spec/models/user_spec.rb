require 'spec_helper'

describe User do
  before(:each) do
    @attributes = {
      :name => rand_str,
      :email => rand_str
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attributes)
  end
  
  it "should require name" do
    no_name_user = User.new(@attributes.merge(:name=>""))
    no_name_user.should_not be_valid
  end

  it "should require email" do
    no_email_user = User.new(@attributes.merge(:email=>""))
    no_email_user.should_not be_valid
  end

  it "should not allow user names with more than 50 chars" do
    name = "a" * 52
    invalid_user = User.new(@attributes.merge(:name => name))
    invalid_user.should_not be_valid
  end

  it "should not allow more than one user with same email" do
    User.create!(@attributes)
    dup_user = User.new(@attributes.merge(:name => rand_str()))
    dup_user.should_not be_valid
  end
  
end

def rand_str(length=20)
  (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle[0..length].join
end

