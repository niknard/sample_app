require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "ROR tutorial" }

  describe "Home page" do
    it "should have a content 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have a right title like 'BASE_TITLE | Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe "Contact page" do
    it "should have a content 'Contact Page'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/contact'
      expect(page).to have_content('Contact Page')
    end

    it "should have a right title like BASE_TITLE | Contact" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{base_title} | Contact")
    end
  end

  describe "Help page" do
    it "should have a content 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have a right title like 'BASE_TITLE | Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
    it "should have a content 'About Us'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have a right title like 'BASE_TITLE | About'" do
      visit '/static_pages/about'
      expect(page).to have_title("#{base_title} | About")
    end
  end
  
end
