require 'spec_helper'

describe "User pages" do

  subject { page }
  
  describe "destroy yourself (admin)" do
    let(:admin) {FactoryGirl.create(:admin)}
    
    before do 
      puts User.count
      sign_in admin
      remember_token = User.new_remember_token
      cookies[:remember_token] = remember_token
      admin.update_attribute(:remember_token, User.encrypt(remember_token))
    end
    
    it do
      expect do
        delete user_path(admin)
      end.not_to change(User, :count).by(-1)
    end
    
  end  
  
  describe "shouldn't show w/o authorization" do
    let(:user){ FactoryGirl.create(:user) }
    before { visit root_path }

    it { should_not have_content('Profile') }
    it { should_not have_content('Settings') }
  end
  
  describe "Index" do
    let(:user){ FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "Pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector('div.pagination') }
      
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end      
      
    end
    
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end

        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

  end

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
        fill_in "Name",          with: "Michael Hartl"
        fill_in "Email",         with: "michael@example.com"
        fill_in "Password",      with: "foobar"
        fill_in "Confirmation",  with: "foobar"
      end
      
      it "should create user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "michael@example.com") }
        
        it { should have_link("Sign out") }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      
      describe "after saving the user text should have user name" do
        before { click_button submit }
        let(:user) { User.find_by(email: "michael@example.com") }
        it { should have_selector('div.alert.alert-success', text: user.name)}
      end
      
    end
    
  end
  
  describe "profile page" do

    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    before {visit user_path(user)}
    
    it {should have_content(user.name)}
    it {should have_title(user.name)}
    
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
    
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with valid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
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