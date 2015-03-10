require 'rails_helper'

feature 'Admin creates a new admin user' do
  
  let!(:admin) { create(:admin_user) }  
  let(:new_admin) { build(:new_admin_user) }
  
  scenario 'with valid input' do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_admin_users_path    
    click_link 'New Admin User'
    fill_in 'Email', with: new_admin.email
    fill_in 'Password*', with: new_admin.password
    fill_in 'Password confirmation', with: new_admin.password
    click_button 'Create Admin user'    
    expect(page).to have_content 'Admin user was successfully created.'
  end
  
  scenario 'with invalid input' do
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_admin_users_path    
    click_link 'New Admin User'
    click_button 'Create Admin user'    
    expect(page).to have_content "can't be blank"
  end
end
