require 'rails_helper'

feature 'Admin creates a new admin user' do
  
  let!(:admin) { create(:admin_user) }  
  let(:new_admin) { build(:new_admin_user) }
  
  before(:each) do
    sign_up_with admin  
    visit admin_admin_users_path             
    click_link 'New Admin User'
  end
  
  scenario 'with valid input' do   
    fill_in 'Email', with: new_admin.email
    fill_in 'Password*', with: new_admin.password
    fill_in 'Password confirmation', with: new_admin.password
    click_button 'Create Admin user'    
    expect(page).to have_content 'Admin user was successfully created.'
  end
  
  scenario 'with invalid input' do
    click_button 'Create Admin user'    
    expect(page).to have_content "can't be blank"
  end
end
