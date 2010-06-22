require 'spec_helper'

describe User do
  before(:each) do
    str = rand_str;
    @attributes = {
      :name => str,
      :email => str,
      :password => str,
      :password_confirmation => str
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
  
  #password validations
  describe "Password validations" do
    before(:each) do
      @user = User.create!(@attributes)
    end
    
    it "shoud require a password" do
      no_passwd_user = User.new(@attributes.merge(:password=>""))
      no_passwd_user.should_not be_valid
    end
    
    it "shoud confirm a password" do
      User.new(@attributes.merge(:password_confirmation=>rand_str)).
      should_not be_valid
    end
    
    it "should reject short passwords" do
      User.new(@attributes.merge(:password => 'a'*5)).
      should_not be_valid
    end
    
    it "should reject long passwords" do
      User.new(@attributes.merge(:password => 'a'*50)).
      should_not be_valid
    end
    
    it "should have an encrypted password" do
      @user.should respond_to("encrypted_password") 
    end
    
    it "encrypted password should not be blank" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attributes[:password]).should be_true
      end
      
      it "should be false if the passwords dont match" do
        @user.has_password?(rand_str).should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil when the password/email dont match" do
        user_password_no_match = User.authenticate(@attributes[:email], rand_str)
        user_password_no_match.should be_nil
      end
      
      it "should return user when password/email match" do
        user_match = User.authenticate(@attributes[:email], @attributes[:password])
        user_match.should == @user
      end
      
      it "should return nil when user with email doesn't exist" do
        user_match = User.authenticate(rand_str, @attributes[:password])
        user_match.should be_nil        
      end
      
    end

  end
  
  describe "remember me" do
    before(:each) do
      @user = User.create!(@attributes)
    end
    
    it "should respond to remember_me! method" do
      @user.should respond_to(:remember_me!)
    end

    it "should respond to remember_token attribute" do
      @user.should respond_to(:remember_token)
    end
    
    it "should set the remember_token attribute" do
      @user.remember_me!
      @user.remember_token.should_not be_nil
    end
    
    
  end # end of remember me tests
  
end

