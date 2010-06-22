require 'spec_helper'

describe "LayoutLinks" do
  
  it "should display home page at '/'" do
    get '/'
    response.should render_template("pages/home")
  end
  
  it "should display contact page at '/'" do
    get '/contact'
    response.should render_template("pages/contact")
  end
  
  it "should display about page at '/'" do
    get '/about'
    response.should render_template("pages/about")
  end

  it "should get render proper sign up page" do
    get '/signup'
    response.should render_template("users/new")
  end


  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should render_template('pages/about')
    click_link "Contact"
    response.should render_template("pages/contact")
    click_link "Home"
    response.should render_template("pages/home")
    click_link "Sign up Now"
    response.should render_template("users/new")
  end
  
  describe "when not signed in" do
    it "should have sign in link" do
      visit root_path
      response.should have_tag("a[href=?]", signin_path, "Sign in")
    end
  end #end of when not signed in

  describe "when signed in " do
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end
    
    it "should have sign out link" do
      visit root_path
      response.should have_tag("a[href=?]", signout_path, "Sign out")
    end
    
  end #end of when signed in

    
end
