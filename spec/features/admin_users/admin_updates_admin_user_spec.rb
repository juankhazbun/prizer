require 'rails_helper'

feature 'Admin updates an admin user' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:new_admin) { create(:new_admin_user) } 
  let(:new_admin_password) { build(:new_admin_password) }
  
  before(:each) do
    sign_up_with admin    
    visit admin_admin_users_path    
    find(:xpath, "//a[@href='/admin/admin_users/2/edit']").click
  end  
  
  scenario 'with valid input' do        
    fill_in 'Password*', with: new_admin_password.password
    fill_in 'Password confirmation', with: new_admin_password.password
    click_button 'Update Admin user'   
    expect(page).to have_content 'Admin user was successfully updated.'
  end
  
  scenario 'with invalid input' do
    fill_in 'Email', with: ''
    click_button 'Update Admin user'    
    expect(page).to have_content "can't be blank"
  end
end
