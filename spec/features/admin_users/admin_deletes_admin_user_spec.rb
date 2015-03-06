require 'rails_helper'

feature 'Admin deletes an admin user' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:new_admin) { create(:new_admin_user) } 
  
  scenario do    
    sign_up_with admin    
    visit admin_admin_users_path    
    find(:xpath, "//a[@href='/admin/admin_users/2' and @data-method='delete']").click
    expect(page).to have_content 'Admin user was successfully destroyed.'
    expect(page).to_not have_content new_admin.email
  end
end
