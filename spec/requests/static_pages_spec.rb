require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have a content 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end

  describe "Help page" do
    it "should have a content 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end

  describe "About page" do
    it "should have a content 'About Us'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
  end
  
  describe "Right titles" do
    it "should have a right title like 'ROR tutorial | Home'" do
      visit '/static_pages/home'
      expect(page).to have_title('ROR tutorial | Home')
    end
  end
  
  

end
