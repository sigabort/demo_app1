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
  
  
  describe "POST 'create'" do
    
    describe "failure" do
      before (:each) do
        @attrs = {:name => "", :email => "", :password => "", :password_confirmation => ""}
        @user = Factory.build(:user, @attrs)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(false)
      end
      
      it "should have right title" do
        post :create, :user => @atrrs
        response.should have_tag("title", /sign up/i)
      end

      it "should render 'new' page" do
        post :create, :user => @atrrs
        response.should render_template('new')
      end

      it "should render empty passwords" do
        post :create, :user => @attrs.merge(:password => rand_str)
        response.should render_template('new')
        response.should have_tag("input[type=?][value=?]", "password" "")
      end

    end
    
    describe "success" do
      before (:each) do
        str = rand_str
        @attrs = {:name => str, :email => str, :password => str, :password_confirmation => str}
        @user = Factory(:user, @attrs)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(true)
      end

      it "should show user page after successful signup" do
        post :create, :user => @attrs
        response.should redirect_to(user_path(@user))
      end

      it "should show flash message after successful signup" do
        post :create, :user => @attrs
        response.should redirect_to(user_path(@user))
        flash[:success].should =~ /Welcome to demo App/i
      end
      
    end
    
  end
  
end
