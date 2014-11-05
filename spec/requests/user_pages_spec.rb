require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      
      it "should'n create user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }
        it { should have_title ('Sign up') }
        it { should have_content ('error') }
      end
      
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",      with: "Example User"
        fill_in "Email",         with: "user@example.com"
        fill_in "Password",      with: "123456"
        fill_in "Confirmation",  with: "123456"
      end
      
      it "should create user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      
      describe "after saving the user text should have user name" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        it { should have_selector('div.alert.alert-success', text: user.name)}
      end
      
    end
    
  end
  
  describe "profile page" do

    let(:user) { FactoryGirl.create(:user) }
    before {visit user_path(user)}
    
    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end
  
#  describe "Check fill in sign up form" do
#    before do 
#      visit signup_path 
#      fillin "Name",          with: "Example User"
#      fillin "Email",         with: "user@example.com"
#      fillin "Password",      with: "123456"
#      fillin "Confirmation",  with: "123456"
#    end
#    click_button "Create my account"
#  end
  
end