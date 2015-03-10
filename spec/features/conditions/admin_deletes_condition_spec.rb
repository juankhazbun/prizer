require 'rails_helper'

feature 'Admin deletes a condition' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:condition) { create(:condition) }  
  
  scenario do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_conditions_path    
    click_link 'Delete'    
    expect(page).to have_content 'Condition was successfully destroyed.'
    expect(page).to_not have_content condition.cond_type
  end
end
