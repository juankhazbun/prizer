require 'rails_helper'

feature 'Admin updates a condition' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:condition) { create(:condition) }  
  let(:new_condition) { build(:new_condition) } 
  
  scenario 'with valid input' do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_conditions_path    
    click_link 'Edit'
    select new_condition.prize.description, from: 'Prize'
    select new_condition.cond_type, from: 'Cond type'  
    fill_in 'Criteria', with: new_condition.criteria
    click_button 'Update Condition'    
    expect(page).to have_content 'Condition was successfully updated.'
  end
  
  scenario 'with invalid input' do
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_conditions_path    
    click_link 'Edit'
    fill_in 'Criteria', with: ''
    click_button 'Update Condition'    
    expect(page).to have_content "can't be blank and is invalid"
  end
end
