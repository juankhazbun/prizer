require 'rails_helper'

describe " Static pages" do
  
    describe "Home Page" do
      
      it "should have title 'Home'" do
        visit root_path
        expect(page).to have_title("Prizer | Home")
      end
      
      it "should have the content 'Store Name'" do
        visit root_path
        expect(page).to have_link('Subscribe!', href: subscribe_path)
      end
    end
end
