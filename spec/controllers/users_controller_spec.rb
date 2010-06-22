require 'spec_helper'

describe UsersController do
  integrate_views

  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should get sign up title" do
      get 'new'
      response.should have_tag("title", /Sign up/)
    end
  end


  describe "GET 'show'" do
    before (:each) do
      @user = Factory(:user)
      User.stub!(:find, @user.id).and_return(@user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should contain user's name in title" do
      get :show, :id => @user
      response.should have_tag("title", /#{@user.name}/)
    end

    it "should contain user's name in body" do
      get :show, :id => @user
      response.should have_tag("h2", /#{@user.name}/)
    end

    it "should contain gravatar image" do
      get :show, :id => @user
      response.should have_tag("h2>img", :class=>"gravatar")
    end
    
  end
  
end
