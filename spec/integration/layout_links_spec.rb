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

    
end
