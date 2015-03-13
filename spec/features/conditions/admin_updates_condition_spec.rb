require 'rails_helper'

feature 'Admin updates a condition' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:condition) { create(:condition) }  
  let(:new_condition) { build(:new_condition) } 
  
  before(:each) do
    sign_up_with admin    
    visit admin_conditions_path    
    click_link 'Edit'
  end
  
  scenario 'with valid input' do 
    select new_condition.prize.description, from: 'Prize'
    select new_condition.cond_type, from: 'Cond type'  
    fill_in 'Criteria', with: new_condition.criteria
    click_button 'Update Condition'    
    expect(page).to have_content 'Condition was successfully updated.'
  end
  
  scenario 'with invalid input' do
    fill_in 'Criteria', with: ''
    click_button 'Update Condition'    
    expect(page).to have_content "can't be blank and is invalid"
  end
end
