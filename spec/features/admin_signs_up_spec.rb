require 'rails_helper'

feature 'Admin signs up' do  
  
  let!(:admin) { create(:admin_user) }  
    
  scenario 'with valid email and password' do
    admin = build(:admin_user)
    sign_up_with admin    
    expect(page).to have_content('Logout')
  end
  
  scenario 'with invalid email' do
    admin = build(:invalid_admin_email)
    sign_up_with admin    
    expect(page).to have_content('Invalid email or password.')
  end
  
  scenario 'with blank password' do
    admin = build(:invalid_admin_password)
    sign_up_with admin    
    expect(page).to have_content('Invalid email or password.')
  end
  
  
end
