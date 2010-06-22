require 'spec_helper'

describe "Users" do
  
  describe "sign up failure" do
    it "should not create a new user" do
      lambda do
        visit signup_path
        click_button
        response.should render_template('users/new')
        response.should have_tag("div#errorExplanation")
      end.should_not change(User, :count)
    end
        
    
  end

  describe "sign up success" do
    it "should create a new user" do
      lambda do
        visit signup_path
        str = rand_str
        fill_in "Name", :with => str
        fill_in "Email", :with => str
        fill_in "Password", :with => str
        fill_in "Confirmation", :with => str
        click_button
        response.should render_template('users/show')
        response.should_not have_tag("div#errorExplanation")
      end.should change(User, :count).by(1)
    end
        
    
  end
  
end
