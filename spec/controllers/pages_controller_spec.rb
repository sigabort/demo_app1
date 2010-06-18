require 'spec_helper'

describe PagesController do
  integrate_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have correct title" do
      get 'home'
      response.should have_tag("title",
                               "Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have correct title" do
      get 'contact'
      response.should have_tag("title",
                               "Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have correct title" do
      get 'about'
      response.should have_tag("title",
                               "About")
    end

  end

end
