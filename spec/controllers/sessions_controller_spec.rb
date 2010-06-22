require 'spec_helper'

describe SessionsController do
  integrate_views

  #Delete these examples and add some real ones
  it "should use SessionsController" do
    controller.should be_an_instance_of(SessionsController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have right title" do
      get 'new'
      response.should have_tag("title", /sign in/i)
    end
    
    it "should render proper template" do
      get 'new'
      response.should render_template('sessions/new')
    end
    
  end
  
  
  describe "POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = {:email => rand_str, :password => rand_str}
        User.should_receive(:authenticate).
        with(@attr[:email], @attr[:password]).
        and_return(nil)
      end
      
      it "should have proper title" do
        post :create, :session => @attr
        response.should have_tag("title", /sign in/i)
      end
      
      it "should render sign in page" do
        post :create, :session => @attr
        response.should render_template("sessions/new")
      end

      it "should render have error message" do
        post :create, :session => @attr
        response.should have_tag("div.flash.error")
      end
      
    end #end of invalid signin
    
    
    describe "valid signin" do
      before(:each) do
        @user = Factory(:user)
        @attr = {:email => @user.email, :password => @user.password}
        User.should_receive(:authenticate).
        with(@attr[:email], @attr[:password]).
        and_return(@user)
      end
      
      it "should set current_user when signedin" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
    end #end of valid signin
    
    
    describe "DELETE destroy" do
      it "user should not be logged in after deleting session" do
        test_sign_in(Factory(:user))
        controller.should be_signed_in
        delete :destroy
        controller.current_user.should be_nil
        controller.should_not be_signed_in
        response.should redirect_to(root_path)
      end
    end # end of DELETE destroy
    
  end
  
end
