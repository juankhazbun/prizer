require 'rails_helper'

feature 'Admin creates a new prize' do
  
  let!(:admin) { create(:admin_user) }  
  let(:prize) { build(:prize)  } 
  
  before(:each) do
    sign_up_with admin    
    visit admin_prizes_path     
    click_link 'New Prize'
  end
  
  scenario 'with valid input' do   
    fill_in 'Description', with: prize.description
    fill_in 'Existences', with: prize.existences
    click_button 'Create Prize'    
    expect(page).to have_content 'Prize was successfully created.'
  end
  
  scenario 'with invalid input' do
    click_button 'Create Prize'    
    expect(page).to have_content "can't be blank"
  end
end
