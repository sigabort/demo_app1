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

    
end
