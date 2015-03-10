require 'rails_helper'

feature 'Admin updates a prize' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:prize) { create(:prize) }  
  let(:new_prize) { build(:new_prize) } 
  
  scenario 'with valid input' do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_prizes_path    
    click_link 'Edit'
    fill_in 'Description', with: new_prize.description
    fill_in 'Existences', with: new_prize.existences
    click_button 'Update Prize'    
    expect(page).to have_content 'Prize was successfully updated.'
  end
  
  scenario 'with invalid input' do
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_prizes_path    
    click_link 'Edit'
    fill_in 'Description', with: ''
    click_button 'Update Prize'    
    expect(page).to have_content "can't be blank"
  end
end
