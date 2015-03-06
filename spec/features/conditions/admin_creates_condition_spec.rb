require 'rails_helper'

feature 'Admin creates a new condition' do
  
  let!(:admin) { create(:admin_user) }  
  
  scenario 'with valid input' do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_conditions_path    
    condition = build(:condition_desc)    
    click_link 'New Condition'
    select condition.prize.description, from: 'Prize'
    select condition.cond_type, from: 'Cond type'  
    fill_in 'Criteria', with: condition.criteria
    click_button 'Create Condition'    
    expect(page).to have_content 'Condition was successfully created.'
  end
  
  scenario 'with invalid input' do
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_conditions_path    
    click_link 'New Condition'
    click_button 'Create Condition'    
    expect(page).to have_content "can't be blank and is invalid"
  end
end
