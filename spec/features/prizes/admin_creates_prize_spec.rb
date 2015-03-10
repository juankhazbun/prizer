require 'rails_helper'

feature 'Admin creates a new prize' do
  
  let!(:admin) { create(:admin_user) }  
  let(:prize) { build(:prize)  } 
  
  scenario 'with valid input' do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_prizes_path     
    click_link 'New Prize'
    fill_in 'Description', with: prize.description
    fill_in 'Existences', with: prize.existences
    click_button 'Create Prize'    
    expect(page).to have_content 'Prize was successfully created.'
  end
  
  scenario 'with invalid input' do
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_prizes_path    
    click_link 'New Prize'
    click_button 'Create Prize'    
    expect(page).to have_content "can't be blank"
  end
end
